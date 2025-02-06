//
//  MainTabbarViewModel.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 6.02.2025.
//

import Foundation

class MainTabbarViewModel {
    
    var coins: [Coin] = []
    
    func addCoin(_ coin: Coin) {
        if !coins.contains(where: { $0.nameid == coin.nameid }) {
            coins.append(coin)
            print("Added coin: \(coin.name), total count: \(coins.count)")
        } else {
            print("Coin already exists: \(coin.name)")
        }
    }
    
}
