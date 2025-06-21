//
//  ExchangeRepositoryStub.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

@testable import ExchangeBroker

final class ExchangeRepositoryStub: ExchangeRepositoryProtocol {
    var fetchGetExchanges: Result<[Exchange], NetworkError> = .failure(.invalidData)
    var fetchGetExchangesIcons: Result<[ExchangeIcon], NetworkError> = .failure(.invalidData)
    
    func getExchanges(completion: @escaping (Result<[Exchange], NetworkError>) -> Void) {
        completion(fetchGetExchanges)
    }
    
    func getExchangesIcons(completion: @escaping (Result<[ExchangeIcon], NetworkError>) -> Void) {
        completion(fetchGetExchangesIcons)
    }
}
