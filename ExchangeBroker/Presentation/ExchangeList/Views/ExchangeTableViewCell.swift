//
//  ExchangeTableViewCell.swift
//  CoinExchange
//
//  Created by Luan Cabral on 19/06/25.
//

import UIKit
import Kingfisher
protocol ExchangeTableViewCellDelegate: AnyObject {
    func didTapExchange()
}

final class ExchangeTableViewCell: UITableViewCell {
    static let reuseId = "ExchangeTableViewCell"
    
    struct Model {
        let name: String
        let exchandeId: String
        let volumeDay: String
        let imageURL: String?
    }
    
    private enum Constants {
        static let imageViewSize: CGFloat = 32
        static let defaultMargin: CGFloat = 16
    }
    
    private lazy var containterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.3)
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: -3, height: 3)
        view.layer.shadowRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var exchangeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var exchangeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var exchangeIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var volumeDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func setupCell(model: Model) {
        setupView()
        exchangeNameLabel.text = model.name
        exchangeIdLabel.text = model.exchandeId
        volumeDayLabel.text = model.volumeDay
        
        guard let imageUrl = model.imageURL, let url = URL(string: imageUrl) else {
            exchangeImageView.image = UIImage(systemName: "photo.circle")
            return
        }
        exchangeImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.circle"))
    }
    
    override func prepareForReuse() {
        exchangeImageView.image = nil
        exchangeNameLabel.text = nil
    }
}

extension ExchangeTableViewCell: ViewCode {
    func setupHierarchy() {
        contentView.addSubview(containterView)
        containterView.addSubview(exchangeImageView)
        containterView.addSubview(exchangeNameLabel)
        containterView.addSubview(exchangeIdLabel)
        containterView.addSubview(volumeDayLabel)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            containterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            exchangeImageView.topAnchor.constraint(greaterThanOrEqualTo: containterView.topAnchor, constant: Constants.defaultMargin),
            exchangeImageView.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: Constants.defaultMargin),
            exchangeImageView.centerYAnchor.constraint(equalTo: containterView.centerYAnchor),
            exchangeImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize),
            exchangeImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize),
            exchangeImageView.bottomAnchor.constraint(lessThanOrEqualTo: containterView.bottomAnchor, constant: -Constants.defaultMargin),
            
            exchangeNameLabel.topAnchor.constraint(greaterThanOrEqualTo: containterView.topAnchor, constant: Constants.defaultMargin),
            exchangeNameLabel.leadingAnchor.constraint(equalTo: exchangeImageView.trailingAnchor, constant: Constants.defaultMargin),
            
            volumeDayLabel.centerYAnchor.constraint(equalTo: containterView.centerYAnchor),
            volumeDayLabel.leadingAnchor.constraint(equalTo: exchangeNameLabel.trailingAnchor, constant: Constants.defaultMargin),
            volumeDayLabel.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -Constants.defaultMargin),
            
            exchangeIdLabel.topAnchor.constraint(equalTo: exchangeNameLabel.bottomAnchor, constant: 4),
            exchangeIdLabel.leadingAnchor.constraint(equalTo: exchangeImageView.trailingAnchor, constant: Constants.defaultMargin),
            exchangeIdLabel.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -Constants.defaultMargin),
            exchangeIdLabel.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -Constants.defaultMargin)
        ])
    }
}

