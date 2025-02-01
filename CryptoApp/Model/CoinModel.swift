//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import Foundation

// MARK: - Coin Detay Modeli
struct CoinDetail: Codable {
    let id: String
    let name: String
    let symbol: String
    let logo: String

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case logo = "logo"
    }
}

// MARK: - Coin Fiyat Modeli
struct CoinPrice: Codable {
    let quotes: Quotes
    
    struct Quotes: Codable {
        let USD: PriceInfo
    }
    
    struct PriceInfo: Codable {
        let price: Double
    }
}
