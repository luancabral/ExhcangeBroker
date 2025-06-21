//
//  NetworkError.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidData
    case invalidResponse
    case serverError(String)
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .invalidData:
            return "Invalid Data"
        case .invalidResponse:
            return "Invalid response from server"
        case .serverError(let message):
            return "Server error: \(message)"
        }
    }
}
