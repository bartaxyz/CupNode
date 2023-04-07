//
//  NFTsView.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct NFTsView: View {
    @ObservedObject var viewModel: NFTsViewModel = NFTsViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.tokens.isEmpty {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 40) {
                        ForEach(viewModel.tokens) { token in
                            NFTItem(token: token.token)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                }
                .navigationTitle("NFTs")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            viewModel.fetchNFTs()
        }
    }
}

struct NFTsView_Previews: PreviewProvider {
    static var previews: some View {
        NFTsView()
    }
}
