//
//  TokenRow.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct TokenRow: View {
    var token: NXYZTokenTypes.Token
    
    var body: some View {
        HStack() {
            if
                let symbolLogos = token.symbolLogos,
                !symbolLogos.isEmpty,
                let imageUrl = URL(string: token.symbolLogos!.first!.URI)
            {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 32, height: 32)
                }
            } else {
                Circle()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.primary.opacity(0.2))
                    .overlay(
                        Image(systemName: "questionmark")
                            .foregroundColor(Color(.systemBackground))
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if token.name != nil {
                    Text(token.name!)
                }
                if token.symbol != nil {
                    Text(token.symbol!)
                        .font(.caption)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                if let value = token.fiat?.first?.pretty {
                    Text("$\(value)")
                }
                if let change = token.fiat?.first?.percentChange24Hour {
                    Text("\(change, specifier: "%.2f")%")
                        .foregroundColor(change >= 0 ? .green : .red)
                        .font(.caption)
                }
            }
        }
    }
}

struct TokenRow_Previews: PreviewProvider {
    static var previews: some View {
        let blockchain = NXYZTokenTypes.Blockchain(name: "Ethereum", shortName: "Ether", chainID: "1", shortChainID: "1")
        let fiat = NXYZTokenTypes.Fiat(value: "53.35", tokenValue: 53.35, pretty: "53.35", decimals: 2, percentChange24Hour: nil, symbol: "USD", name: "USD", updateTime: nil)
        let token = NXYZTokenTypes.Token(blockchain: blockchain, value: "53.35", tokenValue: 53.35, fiat: [fiat], pretty: "53.35", decimals: 2, symbol: "ETH", contractAddress: "0x00...00", name: "ETH", symbolLogos: [])
        TokenRow(token: token)
    }
}
