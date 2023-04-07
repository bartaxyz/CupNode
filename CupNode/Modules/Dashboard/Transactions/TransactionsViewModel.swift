//
//  TransactionsViewModel.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

class TransactionsViewModel: ObservableObject {
    @Published var transactions = [NXYZTransactionTypes.TransactionWithID]()
    @Published var isLoading = false
    
    private let apiService: NXYZApiService
    private let walletAddress: String
    
    init() {
        self.apiService = NXYZApiService()
        self.walletAddress = UserPreferences().getWalletAddress()
    }
    
    func fetchTransactions() {
        isLoading = true
        apiService.getTransactions(for: walletAddress) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let transactions):
                    self.transactions = transactions
                case .failure(let error):
                    // handle error
                    print(error)
                }
            }
        }
    }
}
