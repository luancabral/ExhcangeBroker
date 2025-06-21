//
//  ExchangeScrollableDetailsView.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 20/06/25.
//

import UIKit

protocol ExchangeScrollableDetailsViewDelegate: AnyObject {
    func webSiteButtonTapped(with website: String)
}

final class ExchangeScrollableDetailsView: UIView {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    weak var delegate: ExchangeScrollableDetailsViewDelegate?
    
    init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setup(with model: ExchangeDetailsView.Model) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let detailsView = ExchangeDetailsView()
        detailsView.setup(with: model)
        detailsView.delegate = self
        stackView.addArrangedSubview(detailsView)
        setupView()
    }
}

extension ExchangeScrollableDetailsView: ExchangeDetailsViewDelegate {
    func webSiteButtonTapped(with website: String) {
        delegate?.webSiteButtonTapped(with: website)
    }
}

extension ExchangeScrollableDetailsView: ViewCode {
    func setupHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
