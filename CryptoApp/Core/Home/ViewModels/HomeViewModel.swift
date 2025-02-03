//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import Foundation
import Alamofire


class HomeViewModel {
    
    var coins: [Coin] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var reloadData: (() -> Void)?
    
    func fetchCoins() {
        NetworkManager.shared.fetchCoinData { result in
            switch result {
            case .success(let success):
                self.coins = success.data
                self.reloadData?()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
