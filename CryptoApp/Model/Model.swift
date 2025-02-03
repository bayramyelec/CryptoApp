//
//  Model.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 2.02.2025.
//

import Foundation

struct CoinModel: Codable {
    let data: [Coin]
}

struct Coin: Codable {
    let id, symbol, name, nameid: String
    let rank: Int
    let priceUsd, percentChange24H, percentChange1H, percentChange7D: String
    let priceBtc, marketCapUsd: String
    let volume24, volume24A: Double
    let csupply, tsupply: String
    let msupply: String?
    var logoUrl : String {
        return "https://www.coinlore.com/img/\(nameid).webp"
    }

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, nameid, rank
        case priceUsd = "price_usd"
        case percentChange24H = "percent_change_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange7D = "percent_change_7d"
        case priceBtc = "price_btc"
        case marketCapUsd = "market_cap_usd"
        case volume24
        case volume24A = "volume24a"
        case csupply, tsupply, msupply
    }
}
