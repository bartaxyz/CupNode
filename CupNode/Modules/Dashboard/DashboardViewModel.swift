//
//  DashboardViewModel.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

class DashboardViewModel: ObservableObject {
    
    // Properties for the view model
    @Published var walletAddress: String
    @Published var tokensViewModel: TokensViewModel
    @Published var nftsViewModel: NFTsViewModel
    @Published var transactionsViewModel: TransactionsViewModel
    
    // Initialization method
    init() {
        self.walletAddress = UserPreferences().getWalletAddress()
        self.tokensViewModel = TokensViewModel()
        self.nftsViewModel = NFTsViewModel()
        self.transactionsViewModel = TransactionsViewModel()
    }
    
    // Other methods and functions for the view model
    
}
