//
//  ExchangeDetailsView.swift
//  ExchangeBroker
//
//  Created by Luan Cabral on 19/06/25.
//

import UIKit

protocol ExchangeDetailsViewDelegate: AnyObject {
    func webSiteButtonTapped(with website: String)
}

final class ExchangeDetailsView: UIView {
    struct Model {
        let iconURL: String?
        let exchangeName: String
        let detailsList: [ExchangeDetailsRowView.Model]
        let exchangeWebSite: String?
    }
    
    private enum Constants {
        static let imageViewSize: CGFloat = 32
        static let defaultMargin: CGFloat = 16
        static let iconSize: CGFloat = 100
        static let buttonHeight: CGFloat = 44
    }
    
    private lazy var exchangeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var exchangeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private lazy var exchangeMainInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .red
        return label
    }()
    
    private lazy var infoContainerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Características da Corretora"
        return label
    }()
    
    private lazy var infoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: -3, height: 3)
        view.layer.shadowRadius = 3
        return view
    }()
    
    private lazy var detailsRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.setTitle("Visitar site", for: .normal)
        button.layer.cornerRadius = 6
        
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: -3, height: 3)
        button.layer.shadowOpacity = 0.15
        button.layer.shadowRadius = 3
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ExchangeDetailsViewDelegate?
    private var website: String?
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    func setup(with model: Model) {
        exchangeTitle.text = model.exchangeName
        website = model.exchangeWebSite
        setupItems(with: model.detailsList)
        guard let imageUrl = model.iconURL, let url = URL(string: imageUrl) else {
            exchangeIcon.image = UIImage(systemName: "photo.circle")
            return
        }
        
        exchangeIcon.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.circle"))
        if website == nil {
            linkButton.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) { nil }
    
    func setupItems(with model: [ExchangeDetailsRowView.Model]) {
        detailsRowStackView.subviews.forEach { $0.removeFromSuperview() }
        
        for item in model {
            let model = ExchangeDetailsRowView.Model(title: item.title, value: item.value)
            let view = ExchangeDetailsRowView(model)
            detailsRowStackView.addArrangedSubview(view)
        }
    }
    
    @objc
    func buttonTapped() {
        guard let website else { return }
        delegate?.webSiteButtonTapped(with: website)
    }
}

extension ExchangeDetailsView: ViewCode {
    func setupHierarchy() {
        addSubview(exchangeIcon)
        addSubview(exchangeTitle)
        addSubview(infoContainerView)
        infoContainerView.addSubview(infoContainerTitle)
        infoContainerView.addSubview(detailsRowStackView)
        addSubview(linkButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            exchangeIcon.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultMargin),
            exchangeIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            exchangeIcon.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            exchangeIcon.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            
            exchangeTitle.topAnchor.constraint(equalTo: exchangeIcon.bottomAnchor, constant: Constants.defaultMargin),
            exchangeTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            infoContainerView.topAnchor.constraint(equalTo: exchangeTitle.bottomAnchor, constant: Constants.defaultMargin),
            infoContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultMargin),
            infoContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.defaultMargin),
            
            infoContainerTitle.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: Constants.defaultMargin),
            infoContainerTitle.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: Constants.defaultMargin),
            infoContainerTitle.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -Constants.defaultMargin),
            
            detailsRowStackView.topAnchor.constraint(equalTo: infoContainerTitle.bottomAnchor, constant: Constants.defaultMargin),
            detailsRowStackView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: Constants.defaultMargin),
            detailsRowStackView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -Constants.defaultMargin),
            detailsRowStackView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -Constants.defaultMargin),
            
            linkButton.topAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: Constants.defaultMargin),
            linkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultMargin),
            linkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.defaultMargin),
            linkButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            linkButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultMargin)
        ])
    }
}
