//
//  ExchangeWithIcon+Equatable.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//
@testable import ExchangeBroker

extension ExchangeWithIcon: @retroactive Equatable {
    public static func == (lhs: ExchangeWithIcon, rhs: ExchangeWithIcon) -> Bool {
        return lhs.exchange == rhs.exchange &&
        lhs.iconUrl == rhs.iconUrl
    }
}
