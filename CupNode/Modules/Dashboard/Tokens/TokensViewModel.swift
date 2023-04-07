//
//  TokensViewModel.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

class TokensViewModel: ObservableObject {
    @Published var tokens = [NXYZTokenTypes.TokenWithID]()
    @Published var totalBalance: Double? = nil
    @Published var formattedTotalBalance: String? = nil
    @Published var isLoading = false
    
    private let apiService: NXYZApiService
    private let walletAddress: String
    
    init() {
        self.apiService = NXYZApiService()
        self.walletAddress = UserPreferences().getWalletAddress()
    }
    
    func fetchTokens() {
        isLoading = true
        apiService.getTokens(for: walletAddress) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let tokens):
                    self.injectTokens(tokens: tokens)
                case .failure(let error):
                    // handle error
                    print(error)
                }
            }
        }
    }
    
    func injectTokens(tokens: [NXYZTokenTypes.TokenWithID]) {
        self.tokens = tokens
        self.totalBalance = tokens.reduce(0) { $0 + ($1.token.fiat?.first?.tokenValue ?? 0) }
        self.formattedTotalBalance = formatValue(self.totalBalance!, currency: "USD")
    }
    
    func formatValue(_ value: Double, currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
