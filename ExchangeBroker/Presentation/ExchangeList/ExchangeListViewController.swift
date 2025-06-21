//
//  ExchangeListViewController.swift
//  CoinExchange
//
//  Created by Luan Cabral on 18/06/25.
//

import UIKit

final class ExchangeListViewController: BaseViewController {
    private let viewModel: ExchangeListViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: ExchangeListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Exchanges"
        setupPullToRefresh(on: tableView)
        viewModel.fetchExchanges()
        setupView()
    }
    
    private func registerCell() {
        tableView.register(ExchangeTableViewCell.self, forCellReuseIdentifier: ExchangeTableViewCell.reuseId)
    }
}

extension ExchangeListViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setup() {
        registerCell()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ExchangeListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExchangeTableViewCell.reuseId,
                                                       for: indexPath) as? ExchangeTableViewCell  else {
            return .init()
        }
        
        let cellModel = viewModel.buildExchangeCellViewModel(for: indexPath.row)
        cell.setupCell(model: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectExchange(with: viewModel.exchanges[indexPath.row])
    }
}


extension ExchangeListViewController: ExchangeListViewModelViewDelegate {
    func reloadData(with exchanges: [ExchangeWithIcon]) {
        tableView.reloadData()
    }
}

extension ExchangeListViewController: PullToRefreshProtocol {
    func pullToRefreshAction() {
        viewModel.fetchExchanges()
    }
}

