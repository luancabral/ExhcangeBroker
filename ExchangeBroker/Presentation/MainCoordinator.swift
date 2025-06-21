//
//  MainCoordinator.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//
import UIKit

protocol Navigating {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
}

final class MainCoordinator: Navigating {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func start() {
        let exchangeListViewController = ExchangeListFactory().make(navigation: self)
        navigationController?.setViewControllers([exchangeListViewController], animated: true)
    }
}
