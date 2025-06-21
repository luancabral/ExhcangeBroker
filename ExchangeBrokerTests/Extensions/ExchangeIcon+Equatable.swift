//
//  ExchangeIcon+Equatable.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//
@testable import ExchangeBroker

extension ExchangeIcon: @retroactive Equatable {
    public static func == (lhs: ExchangeIcon, rhs: ExchangeIcon) -> Bool {
        return lhs.exchangeId == rhs.exchangeId &&
        lhs.url == rhs.url
    }
}
