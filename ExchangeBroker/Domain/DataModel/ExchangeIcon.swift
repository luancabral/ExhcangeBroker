//
//  ExchangeIcon.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

struct ExchangeIcon: Decodable {
    let exchangeId: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case url
    }
}
