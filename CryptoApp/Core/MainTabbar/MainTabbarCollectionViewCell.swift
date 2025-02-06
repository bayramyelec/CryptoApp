//
//  MainTabbarCollectionViewCell.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 6.02.2025.
//

import UIKit
import Kingfisher

class MainTabbarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainTabbarCollectionViewCell"
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .white
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
        contentView.backgroundColor = .clear
        contentView.addSubview(customImageView)
        customImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(5)
        }
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    func configure(with coin: Coin) {
        nameLabel.text = coin.symbol
        let url = URL(string: coin.logoUrl)
        customImageView.kf.setImage(with: url)
    }
    
}
