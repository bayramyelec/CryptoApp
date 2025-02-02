//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import Foundation
import Alamofire


class HomeViewModel {
    
    var coins: [CoinModel] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var coinDetail: CoinDetail? {
        didSet {
            reloadDetailData?()
        }
    }
    
    var reloadData: (() -> Void)?
    var reloadDetailData: (() -> Void)?
    
    func fetchCoins() {
        NetworkManager.shared.fetchCoinData { result in
            switch result {
            case .success(let success):
                self.coins = success
            case .failure(let failure):
                print(failure)
            }
        }
        reloadData?()
    }
    
}
