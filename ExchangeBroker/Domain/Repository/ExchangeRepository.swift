//
//  ExchangeRepository.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//
import Foundation

protocol ExchangeRepositoryProtocol {
    func getExchanges(completion: @escaping (Result<[Exchange], NetworkError>) -> Void)
    func getExchangesIcons(completion: @escaping (Result<[ExchangeIcon], NetworkError>) -> Void)
}

final class ExchangeRepository {
    private let service: Servicing
    
    init(service: Servicing) {
        self.service = service
    }
    
    private func fetch<T: Decodable>(endpoint: ExchangeAPI, completion: @escaping (Result<T, NetworkError>) -> Void) {
        service.execute(endpoint: endpoint, completion: completion)
    }
}

extension ExchangeRepository: ExchangeRepositoryProtocol {
    func getExchanges(completion: @escaping (Result<[Exchange], NetworkError>) -> Void) {
        fetch(endpoint: .getExchanges) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getExchangesIcons(completion: @escaping (Result<[ExchangeIcon], NetworkError>) -> Void) {
        fetch(endpoint: .getExchangesIcons) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
