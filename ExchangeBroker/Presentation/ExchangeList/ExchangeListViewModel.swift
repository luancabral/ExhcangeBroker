//
//  ExchangeListViewModel.swift
//  CoinExchange
//
//  Created by Luan Cabral on 19/06/25.
//

protocol ExchangeListViewModelViewDelegate: ViewModelDelegate {
    func reloadData(with exchanges: [ExchangeWithIcon])
    func set(loading: Bool)
}

final class ExchangeListViewModel {
    private(set) var exchangeUseCases: ExchangeUseCaseProtocol
    private(set) var exchanges = [ExchangeWithIcon]()
    private let coordinator: ExchangeListCoordinatorProtocol
    weak var delegate: ExchangeListViewModelViewDelegate?
    
    init(exchangeUseCases: ExchangeUseCaseProtocol, coordinator: ExchangeListCoordinatorProtocol) {
        self.exchangeUseCases = exchangeUseCases
        self.coordinator = coordinator
    }
    
    func fetchExchanges() {
        delegate?.set(loading: true)
        exchangeUseCases.getExchangesWithIcons { [weak self] result in
            guard let self else { return }
            self.delegate?.set(loading: false)
            switch result {
            case .success(let exchanges):
                self.exchanges = exchanges
                self.delegate?.reloadData(with: exchanges)
            case .failure(let error):
                self.delegate?.set(error: error, tryAgainAction: self.fetchExchanges)
            }
        }
    }
    
    func didSelectExchange(with exchange: ExchangeWithIcon) {
        coordinator.goToExchangeDetails(with: exchange)
    }
    
    func buildExchangeCellViewModel(for row: Int) -> ExchangeTableViewCell.Model {
        let exchange = exchanges[row]
        return .init(name: exchange.exchange.name ?? exchange.exchange.exchangeId,
                     exchandeId: exchange.exchange.exchangeId,
                     volumeDay: String.formattedAsUSD(from: exchange.exchange.volume1DayUsd),
                     imageURL: exchange.iconUrl)
    }
}
