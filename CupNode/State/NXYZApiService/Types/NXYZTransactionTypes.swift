//
//  Transactions.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

struct NXYZTransactionTypes {
    struct Transaction: Codable {
        let transactionHash: String
        let blockNumber: Int
        let transactionIndex: Int?
        let value: TransactionValue
        let gas: Int?
        let gasFee: TransactionValue?
        let timestamp: String?
        let actions: [String]?
        let status: Int
        let fromAddress: String?
        let toAddress: String?
    }
    
    struct TransactionWithID: Codable, Identifiable {
        let id: String
        let transaction: Transaction?
    }
    
    struct TransactionValue: Codable {
        let blockchain: Blockchain
        let value: String
        let tokenValue: Double
        let fiat: [FiatValue]?
        let historicalFiat: [FiatValue]?
        let pretty: String?
        let decimals: Int?
        let symbol: String
        let name: String
        let symbolLogos: [SymbolLogo]?
    }
    
    struct Blockchain: Codable {
        let name: String
        let shortName: String
        let chainID: String
        let shortChainID: String
    }
    
    struct FiatValue: Codable {
        let value: String
        let tokenValue: Double
        let pretty: String
        let decimals: Int
        let percentChange24Hour: Double?
        let symbol: String
        let name: String
        let updateTime: String?
    }
    
    struct SymbolLogo: Codable {
        let URI: String
        let height: Int
        let width: Int
    }
}
