//
//  ContentView.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct SelectWalletView: View {
    @State private var walletAddress = ""
    @State private var errorMessage = ""
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TextField("Enter Ethereum wallet address", text: $walletAddress)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.vertical, 40)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    
                
                Spacer()
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top)
                        .font(.system(size: 12.0))
                }
                VStack {
                    Button("Select") {}
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .padding(.vertical, 12)
                        .cornerRadius(12)
                        .onTapGesture {
                            print("onTapGesture is triggered")
                            if isValidWalletAddress(walletAddress) {
                                UserPreferences().setWalletAddress(walletAddress)
                                isActive = true
                            } else {
                                errorMessage = "Invalid Ethereum wallet address"
                            }
                        }
                    
                    if isActive {
                        NavigationLink(destination: DashboardView(), isActive: $isActive) {
                            EmptyView()
                        }
                        .frame(width: 0, height: 0)
                        .hidden()
                    }
                }
            }
            .navigationTitle("Select Wallet")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectWalletView()
    }
}
