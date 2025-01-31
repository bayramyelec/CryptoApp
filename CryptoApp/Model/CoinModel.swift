//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import Foundation

struct CoinModel: Codable {
    let id, name, symbol: String
    let rank: Int
    let isNew, isActive: Bool
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, rank
        case isNew = "is_new"
        case isActive = "is_active"
        case type
    }
}

enum TypeEnum: String, Codable {
    case coin = "coin"
    case token = "token"
}
