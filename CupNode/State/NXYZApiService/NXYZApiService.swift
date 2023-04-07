//
//  NXYZApiService.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation
import Alamofire

class NXYZApiService {
    private let baseURL = "https://api.n.xyz/api/v1/"
    private let apikey = Secrets.nxyzAPIKey
    private let allChainIds = "ethereum,polygon,bnb,arbitrumone,optimism,avalanche,gnosis"
    
    private func composeUrlParams(params: [String: String]) -> String {
        let urlParams = params.map { (key, value) -> String in
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return "\(encodedKey)=\(encodedValue)"
        }
        return urlParams.joined(separator: "&")
    }
    
    func composeURL(path: String, params: [String: Any]?) -> String? {
        var components = URLComponents(string: baseURL)!
        components.path += path
        
        if let params = params {
            components.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }
        
        let url = components.url?.absoluteString;
       
        print(url);
        
        return url;
    }
    
    private func createBalancesUrl(path: String, walletAddress: String, params: [String: Any]) -> String? {
        return composeURL(path: "address/\(walletAddress)/balances/\(path)", params: params)
    }
    private func createTransactionsUrl(path: String, walletAddress: String, params: [String: Any]) -> String? {
        return composeURL(path: "address/\(walletAddress)/\(path)", params: params)
    }
    
    func composeParams(additionalParams: [String: Any]? = nil) -> [String: Any] {
        var params: [String: Any] = ["apikey": Secrets.nxyzAPIKey, "chainID": allChainIds]
        
        if let additionalParams = additionalParams {
            for (key, value) in additionalParams {
                params[key] = value
            }
        }
        
        return params
    }
    
    func getTokens(for walletAddress: String, completion: @escaping (Result<[NXYZTokenTypes.TokenWithID], AFError>) -> Void) {
        let url = createBalancesUrl(path: "fungibles", walletAddress: walletAddress, params: composeParams(additionalParams: [
            "filterDust": "true",
            "filterSpam": "true"
        ]))!
        
        AF.request(
            url,
            method: .get
        ).responseDecodable(of: [NXYZTokenTypes.Token].self) { response in
            if let tokens = response.value {
                let tokensWithIDs = tokens.map { token in
                    return NXYZTokenTypes.TokenWithID(
                        id: UUID().uuidString,
                        token: token
                    )
                }
                completion(.success(tokensWithIDs))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
    
    func getNFTs(for walletAddress: String, completion: @escaping (Result<[NXYZNFTTypes.TokenWithID], AFError>) -> Void) {
        let url = createBalancesUrl(path: "nfts", walletAddress: walletAddress, params: composeParams(additionalParams: [
            "filterSpam": "true"
        ]))!
        
        AF.request(
            url,
            method: .get
        ).responseDecodable(of: [NXYZNFTTypes.Token].self) { response in
            if let tokens = response.value {
                let tokensWithIDs = tokens.map { token in
                    return NXYZNFTTypes.TokenWithID(
                        id: UUID().uuidString,
                        token: token
                    )
                }
                completion(.success(tokensWithIDs))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
    
    func getTransactions(for walletAddress: String, completion: @escaping (Result<[NXYZTransactionTypes.TransactionWithID], AFError>) -> Void) {
        let url = createTransactionsUrl(path: "transactions", walletAddress: walletAddress, params: composeParams())!
        
        AF.request(
            url,
            method: .get
        ).responseDecodable(of: [NXYZTransactionTypes.Transaction].self) { response in
            if let transactions = response.value {
                let tokensWithIDs = transactions.map { transaction in
                    return NXYZTransactionTypes.TransactionWithID(
                        id: UUID().uuidString,
                        transaction: transaction
                    )
                }
                completion(.success(tokensWithIDs))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
}
