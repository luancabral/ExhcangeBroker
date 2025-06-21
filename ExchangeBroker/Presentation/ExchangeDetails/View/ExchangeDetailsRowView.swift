//
//  ExchangeDetailsRowView.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//

import UIKit

final class ExchangeDetailsRowView: UIView {
    struct Model {
        let title: String
        let value: String
    }
    
    private var contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(_ model: Model) {
        super.init(frame: .zero)
        setTitleLabel(title: model.title)
        setvalueLabel(value: model.value)
        setupView()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func setTitleLabel(title: String) {
        titleLabel.text = title
        contentStackView.addArrangedSubview(titleLabel)
    }
    
    private func setvalueLabel(value: String) {
        valueLabel.text = value
        contentStackView.addArrangedSubview(valueLabel)
    }
}


extension ExchangeDetailsRowView: ViewCode {
    func setupHierarchy() {
        addSubview(contentStackView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
