//
//  Model.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 2.02.2025.
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

struct CoinDetail: Codable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let isNew: Bool
    let isActive: Bool
    let type: String
    let logo: String?
    let description: String?
    let proofType: String?
    let hashAlgorithm: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, rank, type, logo, description
        case isNew = "is_new"
        case isActive = "is_active"
        case proofType = "proof_type"
        case hashAlgorithm = "hash_algorithm"
    }
}
