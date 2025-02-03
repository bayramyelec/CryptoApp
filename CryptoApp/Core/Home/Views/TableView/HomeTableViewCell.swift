//
//  HomeTableViewCell.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 3.02.2025.
//

import UIKit
import SnapKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    static let identifier: String = "HomeTableViewCell"
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let percentChangelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(orderLabel)
        contentView.addSubview(customImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentChangelabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        orderLabel.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
        }
        customImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalTo(orderLabel.snp.right).offset(10)
            make.width.equalTo(50)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(customImageView.snp.right).offset(10)
        }
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(customImageView.snp.right).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
        }
        percentChangelabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(with model: Coin){
        orderLabel.text = "\(model.rank)"
        let url = URL(string: model.logoUrl)
        customImageView.kf.setImage(with: url)
        nameLabel.text = model.name
        symbolLabel.text = model.symbol
        priceLabel.text = "$\(model.priceUsd)"
        percentChangelabel.text = "\(model.percentChange24H)%"
        
        if percentChangelabel.text?.first == "-"{
            percentChangelabel.textColor = .red
        } else{
            percentChangelabel.textColor = .green
        }
        
    }
    
}
