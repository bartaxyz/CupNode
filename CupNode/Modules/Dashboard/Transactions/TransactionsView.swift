//
//  TransactionsView.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject var viewModel: TransactionsViewModel = TransactionsViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.transactions.isEmpty {
                ProgressView()
            } else {
                List(viewModel.transactions) { transaction in
                    TransactionRow(transaction: transaction.transaction!)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Transactions")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            viewModel.fetchTransactions()
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
