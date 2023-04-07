//
//  DashboardView.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            TabView {
                TokensView(viewModel: viewModel.tokensViewModel)
                    .tabItem {
                        Label("Tokens", systemImage: "dollarsign.circle")
                    }
                
                NFTsView(viewModel: viewModel.nftsViewModel)
                    .tabItem {
                        Label("NFTs", systemImage: "paintbrush.pointed")
                    }
                
                TransactionsView(viewModel: viewModel.transactionsViewModel)
                    .tabItem {
                        Label("Transactions", systemImage: "arrow.triangle.2.circlepath")
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
