//
//  URLSessionDataTaskStub.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//
@testable import ExchangeBroker

final class URLSessionDataTaskStub: URLSessionDataProtocol {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    func resume() {
        closure()
    }
}
