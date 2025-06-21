//
//  ExchangeDetailsViewModel.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//
import Foundation

final class ExchangeDetailsViewModel {
    private let exchange: ExchangeWithIcon
    private let coordinator: ExchangeDetailsCoordinatorProtocol
    
    init(exchange: ExchangeWithIcon, coordinator: ExchangeDetailsCoordinatorProtocol) {
        self.exchange = exchange
        self.coordinator = coordinator
    }
    
    func getExchange() -> ExchangeWithIcon {
        return self.exchange
    }
    
    func getViewTitle() -> String {
        return exchange.exchange.name ?? exchange.exchange.exchangeId
    }
    
    func setExchangeDetailsViewModel() -> ExchangeDetailsView.Model {
        let detailsList = setDetailsList()
        return ExchangeDetailsView.Model(iconURL: exchange.iconUrl,
                                         exchangeName: exchange.exchange.name ?? exchange.exchange.exchangeId,
                                         detailsList: detailsList,
                                         exchangeWebSite: exchange.exchange.website)
    }
    
    func openWebSite(with link: String) {
        guard let linkURL = URL(string: link) else { return }
        coordinator.openWebSite(with: linkURL)
    }
    
    func setDetailsList() -> [ExchangeDetailsRowView.Model] {
        var modelArray: [ExchangeDetailsRowView.Model] = []
        modelArray.append(.init(title: "Exchange ID", value: exchange.exchange.exchangeId))
        modelArray.append(.init(title: "Symbols Count", value: String(exchange.exchange.symbolsCount)))
        modelArray.append(.init(title: "Rank", value: String(exchange.exchange.rank)))
        
        if let quoteStart = exchange.exchange.dataQuoteStart {
            modelArray.append(.init(title: "Data quote Start", value: quoteStart.formatDateToString()))
        }
        
        if let quoteEnd = exchange.exchange.dataQuoteEnd {
            modelArray.append(.init(title: "Data quote end", value: quoteEnd.formatDateToString()))
        }
        
        if let tradeStart = exchange.exchange.dataTradeStart {
            modelArray.append(.init(title: "Trade Start", value: tradeStart.formatDateToString()))
        }
        
        if let tradeEnd = exchange.exchange.dataTradeEnd {
            modelArray.append(.init(title: "Trade End", value: tradeEnd.formatDateToString()))
        }
        
        modelArray.append(.init(title: "Volume (1h USD)", value: String.formattedAsUSD(from: exchange.exchange.volume1HourUsd)))
        modelArray.append(.init(title: "Volume (1d USD)", value: String.formattedAsUSD(from: exchange.exchange.volume1DayUsd)))
        modelArray.append(.init(title: "Volume (1m USD)", value: String.formattedAsUSD(from: exchange.exchange.volume1MonthUsd)))
        
        return modelArray
    }
}
