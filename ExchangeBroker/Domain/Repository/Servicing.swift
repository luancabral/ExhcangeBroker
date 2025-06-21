//
//  Servicing.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

protocol Servicing {
    func execute<T: Decodable>(endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}
