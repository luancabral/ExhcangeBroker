//
//  ExchangeWithIcon.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

struct ExchangeWithIcon {
    let exchange: Exchange
    var iconUrl: String?
    
    init(exchange: Exchange, iconUrl: String? = nil) {
        self.exchange = exchange
        self.iconUrl = iconUrl
    }
}
