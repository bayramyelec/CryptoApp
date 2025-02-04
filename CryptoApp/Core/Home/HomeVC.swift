//
//  HomeVC.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

protocol didSelectCoinDelegate: AnyObject {
    func didSelectCoin(coin: Coin, viewmodel: HomeViewModel)
}

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.text = "Highest Increases"
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
        tableView.coinDelegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerTitleLabel)
        contentView.addSubview(headerView)
        headerView.addSubview(collectionView)
        contentView.addSubview(coinsTitleLabel)
        contentView.addSubview(coinPriceTitleLabel)
        contentView.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(view.snp.height)
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
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
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(70 * 100)
        }
    }
    
    private func setupNavigationBar() {
        CustomNavigationBar(backgroundColor: .black, tintColor: .white, title: "Live Prices")
        navigationItem.rightBarButtonItem = circleButton(imageName: "chevron.right", cornerRadius: 20)
        navigationItem.leftBarButtonItem = circleButton(imageName: "info", cornerRadius: 20)
    }
}

extension HomeVC: didSelectCoinDelegate {
    func didSelectCoin(coin: Coin, viewmodel: HomeViewModel) {
        let vc = DetailVC()
        vc.coin = coin
        vc.viewModel = viewmodel
        navigationController?.pushViewController(vc, animated: true)
    }
}
