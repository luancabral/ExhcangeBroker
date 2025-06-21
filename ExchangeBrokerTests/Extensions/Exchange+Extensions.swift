//
//  Exchange+Extensions.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

@testable import ExchangeBroker

extension Exchange: @retroactive Equatable {
    public static func == (lhs: Exchange, rhs: Exchange) -> Bool {
        return lhs.exchangeId == rhs.exchangeId &&
        lhs.website == rhs.website &&
        lhs.name == rhs.name &&
        lhs.dataQuoteStart == rhs.dataQuoteStart &&
        lhs.dataQuoteEnd == rhs.dataQuoteEnd &&
        lhs.dataOrderbookStart == rhs.dataOrderbookStart &&
        lhs.dataOrderbookEnd == rhs.dataOrderbookEnd &&
        lhs.dataTradeStart == rhs.dataTradeStart &&
        lhs.dataTradeEnd == rhs.dataTradeEnd &&
        lhs.symbolsCount == rhs.symbolsCount &&
        lhs.volume1DayUsd == rhs.volume1DayUsd &&
        lhs.volume1HourUsd == rhs.volume1HourUsd &&
        lhs.volume1MonthUsd == rhs.volume1MonthUsd &&
        lhs.rank == rhs.rank
    }
}

extension Exchange {
    static func fixture(exchangeId: String = String(),
                        website: String? = nil,
                        name: String? = nil,
                        dataQuoteStart: String? = nil,
                        dataQuoteEnd: String? = nil,
                        dataOrderbookStart: String? = nil,
                        dataOrderbookEnd: String? = nil,
                        dataTradeStart: String? = nil,
                        dataTradeEnd: String? = nil,
                        symbolsCount: Int = 0,
                        volume1HourUsd: Double = 123,
                        volume1DayUsd: Double = 456,
                        volume1MonthUsd: Double = 789,
                        rank: Int = 1) -> Exchange {
        .init(exchangeId: exchangeId,
              website: website,
              name: name,
              dataQuoteStart: dataQuoteStart,
              dataQuoteEnd: dataQuoteEnd,
              dataOrderbookStart: dataOrderbookStart,
              dataOrderbookEnd: dataOrderbookEnd,
              dataTradeStart: dataTradeStart,
              dataTradeEnd: dataTradeEnd,
              symbolsCount: symbolsCount,
              volume1HourUsd: volume1HourUsd,
              volume1DayUsd: volume1DayUsd,
              volume1MonthUsd: volume1MonthUsd,
              rank: rank)
    }
}
