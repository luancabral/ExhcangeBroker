//
//  ExchangeDetalisFactory.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//

final class ExchangeDetalisFactory {
    func make(with exchange: ExchangeWithIcon, navigation: Navigating) -> ExchangeDetailsViewController {
        let coordinator = ExchangeDetailsCoordinator(navigation: navigation)
        let viewModel = ExchangeDetailsViewModel(exchange: exchange, coordinator: coordinator)
        let viewController = ExchangeDetailsViewController(viewModel: viewModel)
        
        return viewController
    }
}
