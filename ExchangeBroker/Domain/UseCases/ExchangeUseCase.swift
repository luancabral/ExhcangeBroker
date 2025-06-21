//
//  ExchangeUseCase.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

import Foundation

protocol ExchangeUseCaseProtocol {
    func getExchangesWithIcons(completion: @escaping (Result<[ExchangeWithIcon], NetworkError>) -> Void)
}

final class ExchangeUseCase: ExchangeUseCaseProtocol {
    private let repository: ExchangeRepositoryProtocol
    
    init(repository: ExchangeRepositoryProtocol) {
        self.repository = repository
    }
    
    func getExchangesWithIcons(completion: @escaping (Result<[ExchangeWithIcon], NetworkError>) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        var exchangeResult: Result<[Exchange], NetworkError>?
        var iconResult: Result<[ExchangeIcon], NetworkError>?
        
        dispatchGroup.enter()
        repository.getExchanges { result in
            exchangeResult = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        repository.getExchangesIcons { result in
            iconResult = result
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self,
                  let exchangeResult = exchangeResult,
                  let iconResult = iconResult else {
                completion(.failure(.invalidData))
                return
            }
            
            self.matchExchangeAndIcon(exchangeResult, iconResult) { result in
                completion(result)
            }
        }
    }
    
    private func matchExchangeAndIcon(_ exchangeResult: Result<[Exchange], NetworkError>,
                                      _ iconResult: Result<[ExchangeIcon], NetworkError>,
                                      completion: @escaping (Result<[ExchangeWithIcon], NetworkError>) -> Void) {
        switch (exchangeResult, iconResult) {
        case (.success(let exchanges), .success(let icons)):
            let iconDict = Dictionary(uniqueKeysWithValues: icons.map { ($0.exchangeId, $0.url) })
            let exchangesWithIcons = exchanges.map { exchange in
                ExchangeWithIcon(exchange: exchange, iconUrl: iconDict[exchange.exchangeId])
            }
            
            completion(.success(exchangesWithIcons))
            
        case (.failure(let error), _):
            completion(.failure(error))
            
        case (.success(let exchanges), .failure(_)):
            let exchangesWithoutIcons = exchanges.map { exchange in
                ExchangeWithIcon(exchange: exchange)
            }
            
            completion(.success(exchangesWithoutIcons))
        }
    }
}
