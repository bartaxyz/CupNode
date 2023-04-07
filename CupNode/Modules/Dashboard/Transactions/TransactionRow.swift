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
        VStack(alignment: .leading) {
            Text(transaction.fromAddress)
                .font(.headline)
            Text(transaction.transactionHash)
                .font(.subheadline)
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
