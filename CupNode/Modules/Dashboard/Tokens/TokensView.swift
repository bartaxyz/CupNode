//
//  TokensView.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct TokensView: View {
    @ObservedObject var viewModel: TokensViewModel = TokensViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.tokens.isEmpty {
                ProgressView()
            } else {
                List(viewModel.tokens) { token in
                    TokenRow(token: token.token)
                }
                .padding(.top)
                .navigationTitle("Tokens (\(viewModel.formattedTotalBalance ?? "$-.--"))")
            }
        }
        .onAppear {
            viewModel.fetchTokens()
        }
    }
}

struct TokensView_Previews: PreviewProvider {
    static var previews: some View {
        TokensView()
    }
}
