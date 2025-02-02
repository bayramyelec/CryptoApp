//
//  EndPoint.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 2.02.2025.
//

import UIKit

protocol EndPointProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: httpMethod { get }
    func fullUrl() -> String
    func urlRequest() -> URLRequest
}

enum httpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum EndPoint {
    case getCoinList
    case getCoinDetails(coinId: String)
}

extension EndPoint: EndPointProtocol {
    var baseUrl: String {
        return "https://api.coinpaprika.com/v1/"
    }
    
    var path: String {
        switch self {
        case .getCoinList:
            return "coins"
        case .getCoinDetails(let coinId):
            return "coins/\(coinId)"
        }
    }
    
    var method: httpMethod {
        switch self {
        case .getCoinList:
            return .get
        case .getCoinDetails(_):
            return .get
        }
    }
    
    func fullUrl() -> String {
        return baseUrl + path
    }
    
    func urlRequest() -> URLRequest {
        guard let url = URL(string: fullUrl()) else { fatalError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
