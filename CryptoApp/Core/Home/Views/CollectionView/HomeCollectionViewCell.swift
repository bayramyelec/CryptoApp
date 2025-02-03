//
//  HomeCollectionViewCell.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 3.02.2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HomeCollectionViewCell"
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        backgroundColor = .white.withAlphaComponent(0.2)
        addSubview(customImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(percentLabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        customImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
            make.height.equalTo(70)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom).offset(10)
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.right.equalToSuperview().inset(10)
        }
        percentLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(with model: Coin){
        let url = URL(string: model.logoUrl)
        customImageView.kf.setImage(with: url)
        titleLabel.text = "\(model.symbol)"
        let price = model.priceUsd
        priceLabel.text = String(format: "$%.2f", (Double(price) ?? 0))
        percentLabel.text = "\(model.percentChange24H)%"
        
        if percentLabel.text?.first == ("-") {
            percentLabel.textColor = .red
        } else {
            percentLabel.textColor = .green
        }
    }
    
}
