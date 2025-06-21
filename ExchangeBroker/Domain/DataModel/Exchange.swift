//
//  Exchange.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

struct Exchange: Decodable {
    let exchangeId: String
    let website: String?
    let name: String?
    let dataQuoteStart: String?
    let dataQuoteEnd: String?
    let dataOrderbookStart: String?
    let dataOrderbookEnd: String?
    let dataTradeStart: String?
    let dataTradeEnd: String?
    let symbolsCount: Int
    let volume1HourUsd: Double
    let volume1DayUsd: Double
    let volume1MonthUsd: Double
    let rank: Int
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case website
        case name
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case symbolsCount = "data_symbols_count"
        case volume1HourUsd = "volume_1hrs_usd"
        case volume1DayUsd = "volume_1day_usd"
        case volume1MonthUsd = "volume_1mth_usd"
        case rank
    }
}
