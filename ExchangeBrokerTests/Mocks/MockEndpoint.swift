//
//  MockEndpoint.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//
@testable import ExchangeBroker
import Foundation

enum MockEndpoint {
    case mock
}

extension MockEndpoint: APIEndpoint {
    var baseURL: String {
        return "mock-url"
    }
    
    var path: String {
        return "mockPath"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var version: String {
        return "v1"
    }
    
}
