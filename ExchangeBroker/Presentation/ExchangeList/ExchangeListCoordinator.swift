//
//  ExchangeListCoordinator.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//

protocol ExchangeListCoordinatorProtocol {
    func goToExchangeDetails(with exchange: ExchangeWithIcon)
}

final class ExchangeListCoordinator {
    private let navigation: Navigating
    
    init(navigation: Navigating) {
        self.navigation = navigation
    }
}

extension ExchangeListCoordinator: ExchangeListCoordinatorProtocol {
    func goToExchangeDetails(with exchange: ExchangeWithIcon) {
        let exchangeDetailsViewController = ExchangeDetalisFactory().make(with: exchange, navigation: navigation)
        navigation.pushViewController(exchangeDetailsViewController, animated: true)
    }
}
