//
//  ValidationUtils.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation

func isValidWalletAddress(_ walletAddress: String) -> Bool {
    if walletAddress.isEmpty {
        return false
    }
    
    // Check if wallet address is a valid Ethereum address
    if let ethereumRegex = try? NSRegularExpression(pattern: "^0x[0-9a-fA-F]{40}$") {
        let range = NSRange(location: 0, length: walletAddress.utf16.count)
        if ethereumRegex.firstMatch(in: walletAddress, options: [], range: range) != nil {
            return true
        }
    }
    
    // Check if wallet address is a valid ENS name
    if let ensRegex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.eth$") {
        let range = NSRange(location: 0, length: walletAddress.utf16.count)
        if ensRegex.firstMatch(in: walletAddress, options: [], range: range) != nil {
            return true
        }
    }
    
    // Wallet address is not a valid Ethereum address or ENS name
    return false
}
