//
//  NFTsViewModel.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

class NFTsViewModel: ObservableObject {
    @Published var tokens = [NXYZNFTTypes.TokenWithID]()
    @Published var isLoading = false
    
    private let apiService: NXYZApiService
    private let walletAddress: String
    
    init() {
        self.apiService = NXYZApiService()
        self.walletAddress = UserPreferences().getWalletAddress()
    }
    
    func fetchNFTs() {
        isLoading = true
        apiService.getNFTs(for: walletAddress) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let tokens):
                    self.tokens = tokens
                case .failure(let error):
                    // handle error
                    print(error)
                }
            }
        }
    }
}
