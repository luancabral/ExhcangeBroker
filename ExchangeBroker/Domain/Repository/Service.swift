//
//  Service.swift
//  CoinExchange
//
//  Created by Luan Cabral on 19/06/25.
//

import Foundation

final class Service: Servicing {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func execute<T>(endpoint: APIEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let request = buildRequest(endpoint: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                do {
                    let errorResponse = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                    completion(.failure(.serverError(errorResponse.error)))
                } catch {
                    completion(.failure(.invalidData))
                }
                
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    private func buildRequest(endpoint: APIEndpoint) -> URLRequest? {
        guard let urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            return nil
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        return request
    }
}
