//
//  URLSessionStub.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//
import Foundation
@testable import ExchangeBroker

final class URLSessionStub: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataProtocol {
        return URLSessionDataTaskStub {
            completionHandler(self.data, self.response, self.error)
        }
    }
}
