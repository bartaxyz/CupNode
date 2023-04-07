//
//  ContentView.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import SwiftUI

struct AddWalletView: View {
    @State private var walletAddress = ""
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TextField("Enter Ethereum wallet address or ENS", text: $walletAddress)
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
                
                NavigationLink(destination: DashboardView()) {
                    Text("Select")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.bottom)
                .padding(.horizontal)
                .disabled(!isValidWalletAddress(walletAddress))
                .onTapGesture {
                    if isValidWalletAddress(walletAddress) {
                        saveWalletAddress()
                    } else {
                        errorMessage = "Invalid Ethereum wallet address"
                    }
                }
            }
            .navigationTitle("Select Wallet")
        }
    }
    
    private func saveWalletAddress() {
        UserDefaults.standard.set(walletAddress, forKey: "walletAddress")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddWalletView()
    }
}
