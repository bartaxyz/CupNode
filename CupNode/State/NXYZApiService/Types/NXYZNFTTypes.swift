//
//  NFTs.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

struct NXYZNFTTypes {
    struct Blockchain: Codable {
        let name: String
        let shortName: String
        let chainID: String
        let shortChainID: String
    }
    
    struct MediaVersion: Codable {
        let kind: String?
        let format: String?
        let width: Int?
        let height: Int?
        let numBytes: Int?
    }
    
    struct Media: Codable {
        let key: String?
        let URI: String?
        let version: [MediaVersion]?
    }
    
    struct Address: Codable {
        let address: String
    }
    
    struct BlockchainCollection: Codable {
        let blockchain: Blockchain
        let contractAddress: String
        let symbol: String?
        let slug: String?
        let name: String?
        let description: String?
        let createdDate: String?
        let floorPrice: FloorPrice?
        let totalSupply: Int?
        let bannerImage: BannerImage?
        let featuredImage: FeaturedImage?
        let logoImage: LogoImage?
        let urls: [Url]?
        let socialMedia: [SocialMedia]?
    }
    
    struct FloorPrice: Codable {
        let blockchain: Blockchain
        let value: String
        let tokenValue: Double
        let pretty: String
        let decimals: Int
        let symbol: String
        let contractAddress: String
        let symbolLogos: [SymbolLogo]?
    }
    
    struct SymbolLogo: Codable {
        let URI: String?
        let height: Int?
        let width: Int?
    }
    
    struct BannerImage: Codable {
        let URI: String?
    }
    
    struct FeaturedImage: Codable {
        let URI: String?
    }
    
    struct LogoImage: Codable {
        let URI: String?
    }
    
    struct Url: Codable {
        let name: String?
        let url: String?
    }
    
    struct SocialMedia: Codable {
        let network: String?
        let username: String?
        let url: String?
    }
    
    struct Preview: Codable {
        let URI: String?
        let height: Int?
        let width: Int?
    }
    
    struct NFT: Codable {
        let tokenID: String
        let title: String?
        let contractTitle: String?
        let description: String?
        let media: Media?
        let previews: [Preview]?
        let owner: Address
        let collection: BlockchainCollection?
    }
    
    struct Token: Codable {
        let blockchain: Blockchain
        let contractAddress: String
        let tokenStandard: String
        let symbol: String?
        let nft: NFT
    }
    
    struct TokenWithID: Codable, Identifiable {
        let id: String
        let token: Token
    }
}
