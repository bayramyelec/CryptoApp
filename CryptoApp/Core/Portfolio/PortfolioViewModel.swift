//
//  PortfolioViewModel.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 6.02.2025.
//

import Foundation

class PortfolioViewModel {
    
    var coins: [Coin] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var reloadData: (() -> Void)?
    
}
