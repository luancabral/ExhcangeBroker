//
//  Untitled.swift
//  CoinExchange
//
//  Created by Luan Cabral on 19/06/25.
//

final class ExchangeListFactory {
    func make(navigation: Navigating) -> ExchangeListViewController {
        let service = Service()
        let repository = ExchangeRepository(service: service)
        let exchangeUseCases = ExchangeUseCase(repository: repository)
        let coordinator = ExchangeListCoordinator(navigation: navigation)
        let viewModel = ExchangeListViewModel(exchangeUseCases: exchangeUseCases, coordinator: coordinator)
        let viewController = ExchangeListViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        
        return viewController
    }
}
