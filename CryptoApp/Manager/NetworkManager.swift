//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 2.02.2025.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private func fetchData<T: Decodable>(endPoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endPoint.urlRequest()).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCoinData(completion: @escaping (Result<[CoinModel], Error>) -> Void) {
        let endpoint = EndPoint.getCoinList
        fetchData(endPoint: endpoint, completion: completion)
    }
    
    func fetchCoinDetails(coinId: String, completion: @escaping (Result<CoinDetail, Error>) -> Void) {
        let endpoint = EndPoint.getCoinDetails(coinId: coinId)
        fetchData(endPoint: endpoint) { (result: Result<CoinDetail, Error>) in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
