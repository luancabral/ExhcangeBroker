//
//  APIEndpoint.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

protocol APIEndpoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String : String]? { get }
    var version: String { get }
}

extension APIEndpoint {
    var baseURL: String {
        return "https://rest.coinapi.io/\(version)/"
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
