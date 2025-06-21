//
//  URLSession.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//
import Foundation

protocol URLSessionDataProtocol {
    func resume()
}

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataProtocol
}

extension URLSessionDataTask: URLSessionDataProtocol {}

extension URLSession: URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
