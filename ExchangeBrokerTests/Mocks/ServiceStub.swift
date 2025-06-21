//
//  ServiceStub.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//
@testable import ExchangeBroker

final class ServiceStub: Servicing {
    var mockResponse: Decodable?
    var shouldFail: Bool = false
    
    func execute<T>(endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard !shouldFail, let response = mockResponse as? T else {
            completion(.failure(.invalidData))
            return
        }
        
        completion(.success(response))
    }
}
