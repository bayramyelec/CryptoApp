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
        didSet{
            reloadData?()
        }
    }
    
    var reloadData: (() -> Void)?
    
    func fetchData() {
        AF.request("https://api.coinpaprika.com/v1/coins").responseDecodable(of: [CoinModel].self) { response in
            guard let coins = response.value else { return }
            self.coins = coins
            self.reloadData?()
        }
    }
    
}
