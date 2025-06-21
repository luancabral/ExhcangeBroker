//
//  ExchangeUseCaseStub.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

@testable import ExchangeBroker

final class ExchangeUseCaseStub: ExchangeUseCaseProtocol {
    var fetchExchangeWithIcon: Result<[ExchangeWithIcon], NetworkError> = .failure(.invalidData)
    
    func getExchangesWithIcons(completion: @escaping (Result<[ExchangeWithIcon], NetworkError>) -> Void) {
        completion(fetchExchangeWithIcon)
    }
}
