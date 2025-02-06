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
    
    var filteredCoins: [Coin] = [] {
        didSet {
            reloadFilteredData?()
        }
    }
    
    var topCoins: [Coin] = [] {
        didSet {
            reloadTopCoins?()
        }
    }
    
    var reloadData: (() -> Void)?
    var reloadFilteredData: (() -> Void)?
    var reloadTopCoins: (() -> Void)?
    
    func fetchCoins() {
        NetworkManager.shared.fetchCoinData { result in
            switch result {
            case .success(let success):
                self.coins = success.data
                self.filteredCoins = success.data
                self.reloadData?()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTopCoins() {
        NetworkManager.shared.fetchCoinData { result in
            switch result {
            case .success(let success):
                let list = success.data.filter { Double($0.percentChange24H) ?? 0 > 0 }
                self.topCoins = list.sorted { (Double($0.percentChange24H) ?? 0) > (Double($1.percentChange24H) ?? 0) }
                self.reloadTopCoins?()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func filterCoins(searchText: String) {
        filteredCoins = coins.filter { coin in
            let nameMatch = coin.name.lowercased().contains(searchText.lowercased())
            let symbolMatch = coin.symbol.lowercased().contains(searchText.lowercased())
            return nameMatch || symbolMatch
        }
    }
    
}
