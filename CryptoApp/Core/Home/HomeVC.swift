//
//  HomeVC.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.text = "Top Crypto"
        return label
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let coinsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.text = "Coins"
        return label
    }()
    
    private let coinPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.text = "Prices (24h)"
        return label
    }()
    
    private var tableView = HomeTableView()
    
    private var collectionView = HomeCollectionView()
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(headerView)
        view.addSubview(headerTitleLabel)
        headerView.addSubview(collectionView)
        view.addSubview(coinsTitleLabel)
        view.addSubview(coinPriceTitleLabel)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.equalToSuperview().inset(20)
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(headerTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coinsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
        }
        coinPriceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(coinsTitleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigationBar() {
        CustomNavigationBar(backgroundColor: .black, tintColor: .white, title: "Live Prices")
        navigationItem.rightBarButtonItem = circleButton(imageName: "chevron.right", cornerRadius: 20)
        navigationItem.leftBarButtonItem = circleButton(imageName: "info", cornerRadius: 20)
    }
    
}
