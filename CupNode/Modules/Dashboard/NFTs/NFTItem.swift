//
//  NFTItem.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct NFTItem: View {
    var token: NXYZNFTTypes.Token
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .aspectRatio(1.0, contentMode: .fit)
                .overlay(
                    VStack {
                        if let mediaUri = getOptimalNFTPreview(previews: token.nft.previews, size: 400) {
                            AsyncImage(url: URL(string: mediaUri)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Text("NFT")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .font(.title)
                                .multilineTextAlignment(.center)
                        }
                    }
                )
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            
            Text(token.nft.title ?? "N/A")
                .font(.headline)
                .padding(.top, 4)
                .padding(.bottom, 1)
                .lineLimit(1)
            
            Text(token.nft.description ?? "N/A")
                .font(.caption)
                .foregroundColor(.primary.opacity(0.5))
                .lineLimit(1)
            
        }
    }
}

struct NFTItem_Previews: PreviewProvider {
    static var previews: some View {
        let preview = NXYZNFTTypes.Preview(URI: "https://cataas.com/cat", height: 300, width: 300)
        let media = NXYZNFTTypes.Media(key: "key", URI: "https://cataas.com/cat", version: nil)
        let nft = NXYZNFTTypes.NFT(tokenID: "tokenID", title: "Title of NFT", contractTitle: "Contract Title", description: "Description is here to stay, my maaan! Description is here to stay, my maaan!", media: media, previews: [preview, preview], owner: NXYZNFTTypes.Address(address: "0x0000"), collection: nil)
        let blockchain = NXYZNFTTypes.Blockchain(name: "Ethereum", shortName: "ETH", chainID: "1", shortChainID: "1")
        let token = NXYZNFTTypes.Token(blockchain: blockchain, contractAddress: "0x0000", tokenStandard: "eic:123", symbol: nil, nft: nft)
        NFTItem(token: token)
    }
}
