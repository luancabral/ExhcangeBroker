//
//  ViewCode.swift
//  CoinExchange
//
//  Created by Luan Cabral on 19/06/25.
//

protocol ViewCode {
    func setupHierarchy()
    func addConstraints()
    func setup()
}

extension ViewCode {
    func setupView() {
        setupHierarchy()
        addConstraints()
        setup()
    }
    
    func setup() {}
}
