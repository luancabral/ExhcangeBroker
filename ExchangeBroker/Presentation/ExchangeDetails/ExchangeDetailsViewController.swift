    //
//  ExchangeDetailsViewController.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//

import UIKit

final class ExchangeDetailsViewController: BaseViewController {
    private let viewModel: ExchangeDetailsViewModel
    private lazy var customView: ExchangeScrollableDetailsView = {
        let customView = ExchangeScrollableDetailsView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        return customView
    }()
    
    init(viewModel: ExchangeDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupView()
        title = viewModel.getViewTitle()
        let detailsModel = viewModel.setExchangeDetailsViewModel()
        customView.delegate = self
        customView.setup(with: detailsModel)
    }
}

extension ExchangeDetailsViewController: ExchangeScrollableDetailsViewDelegate {
    func webSiteButtonTapped(with website: String) {
        viewModel.openWebSite(with: website)
    }
}


extension ExchangeDetailsViewController: ViewCode {
    func setupHierarchy() {
        view.addSubview(customView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
