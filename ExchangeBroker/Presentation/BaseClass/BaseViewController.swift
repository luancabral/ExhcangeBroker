//
//  BaseViewController.swift
//  CoinExchange
//
//  Created by Luan Cabral on 19/06/25.
//

import UIKit

protocol ViewModelDelegate: AnyObject {
    func set(loading: Bool)
    func set(error: NetworkError, tryAgainAction: (() -> Void)?)
}

extension ViewModelDelegate where Self: BaseViewController {
    func set(loading: Bool) {
        loading ? startLoder() : stopLoader()
    }
    
    func set(error: NetworkError, tryAgainAction: (() -> Void)?) {
        setupErrorAlert(erroDescription: error.description, tryAgainAction: tryAgainAction)
    }
}
class BaseViewController: UIViewController {
    var loadingView: UIAlertController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func startLoder() {
        guard loadingView == nil else { return }
        let alert = UIAlertController(title: nil, message: "Carregando...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        alert.view.addSubview(indicator)
        loadingView = alert
        self.present(alert, animated: true)
    }
    
    func stopLoader() {
        loadingView?.dismiss(animated: true)
    }
    
    func setupErrorAlert(erroDescription: String, tryAgainAction: (() -> Void)?) {
        let alert = UIAlertController(title: "Ops!", message: erroDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "Tentar novamente", style: .default) {_ in
            tryAgainAction?()
        })
        alert.addAction(.init(title: "Cancelar", style: .destructive) { _ in
            alert.dismiss(animated: true)
        })
        self.present(alert, animated: true)
    }
}

// MARK: - Pull to Refresh
protocol PullToRefreshProtocol {
    func setupPullToRefresh(on tableView: UITableView)
    func pullToRefreshAction()
    
}
extension BaseViewController {
    @objc
    func triggerPullToRefresh(refreshControl: UIRefreshControl) {
        if let pullToRefreshController = self as? PullToRefreshProtocol {
            pullToRefreshController.pullToRefreshAction()
        }
        refreshControl.endRefreshing()
    }
}

extension PullToRefreshProtocol where Self: BaseViewController {
    func setupPullToRefresh(on tableView: UITableView) {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 0.988, green: 0.235, blue: 0.0, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(triggerPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.bounces = true
    }
}
