//
//  NXYZTypes.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

struct NXYZTokenTypes {
    struct Token: Codable {
        let blockchain: Blockchain
        let value: String?
        let tokenValue: Double?
        let fiat: [Fiat]?
        let pretty: String?
        let decimals: Int?
        let symbol: String?
        let contractAddress: String
        let name: String?
        let symbolLogos: [SymbolLogo]?
    }
    
    struct TokenWithID: Codable, Identifiable {
        let id: String
        let token: Token
    }
    
    struct Blockchain: Codable {
        let name: String?
        let shortName: String?
        let chainID: String
        let shortChainID: String?
    }
    
    struct Fiat: Codable {
        let value: String
        let tokenValue: Double?
        let pretty: String
        let decimals: Int?
        let percentChange24Hour: Double?
        let symbol: String?
        let name: String?
        let updateTime: String?
    }
    
    struct SymbolLogo: Codable {
        let URI: String
        let height: Int?
        let width: Int?
    }
}
