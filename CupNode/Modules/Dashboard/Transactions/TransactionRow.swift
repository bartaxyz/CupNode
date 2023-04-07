//
//  TransactionRow.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: NXYZTransactionTypes.Transaction
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            if
                let symbolLogos = transaction.value.symbolLogos,
                !symbolLogos.isEmpty,
                let imageUrl = URL(string: transaction.value.symbolLogos!.first!.URI)
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
                Text(transaction.value.symbol)
                Text(formatRelativeTime(transaction.timestamp))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(formatCurrency(transaction.value.fiat?.first?.tokenValue, currency: "USD"))
                Text("\(transaction.value.symbol) \(transaction.value.tokenValue)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        let blockchain = NXYZTransactionTypes.Blockchain(name: "", shortName: "", chainID: "", shortChainID: "")
        let fiat = NXYZTransactionTypes.FiatValue(value: "50", tokenValue: 50, pretty: "50.00", decimals: 2, percentChange24Hour: nil, symbol: "USD", name: "USD", updateTime: nil)
        let transactionValue = NXYZTransactionTypes.TransactionValue(blockchain: blockchain, value: "10", tokenValue: 10, fiat: [fiat], historicalFiat: nil, pretty: "10.00000000", decimals: 8, symbol: "ETH", name: "Etherum", symbolLogos: nil)
        let transaction = NXYZTransactionTypes.Transaction(transactionHash: "", blockNumber: 0, transactionIndex: nil, value: transactionValue, gas: 3, gasFee: nil, timestamp: nil, actions: nil, status: 4, fromAddress: "0x000", toAddress: "0x000")
        TransactionRow(transaction: transaction)
    }
}
