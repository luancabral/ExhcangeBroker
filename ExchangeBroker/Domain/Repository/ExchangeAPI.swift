//
//  ExchangeAPI.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

enum ExchangeAPI {
    case getExchanges
    case getExchangesIcons
}


extension ExchangeAPI: APIEndpoint {
    var path: String {
        switch self {
        case .getExchanges:
            return "exchanges"
        case .getExchangesIcons:
            return "exchanges/icons/40"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var version: String {
        return "v1"
    }
    
    var headers: [String : String]? {
        return ["X-CoinAPI-Key": ServiceConstants.apiKey]
    }
}
