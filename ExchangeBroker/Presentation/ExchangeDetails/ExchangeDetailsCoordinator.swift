    //
//  ExchangeDetailsCoordinator.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//

import Foundation
import UIKit

protocol ExchangeDetailsCoordinatorProtocol {
    func popViewController()
    func openWebSite(with url: URL)
}

final class ExchangeDetailsCoordinator {
    private let navigation: Navigating
    
    init(navigation: Navigating) {
        self.navigation = navigation
    }
}

extension ExchangeDetailsCoordinator: ExchangeDetailsCoordinatorProtocol {
    func openWebSite(with url: URL) {
        UIApplication.shared.open(url)
    }
    
    func popViewController() {
        navigation.popViewController(animated: true)
    }
}
