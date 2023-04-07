//
//  UserPreferences.swift
//  CupNode
//
//  Created by Ondrej Barta on 07.04.23.
//

import Foundation


class UserPreferences {
    private let walletAddressKey = "walletAddress"
    
    func getWalletAddress() -> String {
        return UserDefaults.standard.string(forKey: walletAddressKey) ?? "0xe6CC08e94d44184e5f412E52f9F1866B6D7C8990"
    }
    
    func setWalletAddress(_ address: String) {
        UserDefaults.standard.set(address, forKey: walletAddressKey)
        UserDefaults.standard.synchronize()
    }
}

