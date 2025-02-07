//
//  HomeCollectionView.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 3.02.2025.
//

import UIKit

class HomeCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Variables
    
    weak var coinDelegate: didSelectCoinDelegate?
    
    var viewModel = HomeViewModel()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
        activityIndicatorSetup()
        viewModel.fetchTopCoins()
        viewModel.reloadTopCoins = { [weak self] in
            DispatchQueue.main.async {
                self?.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Funcs
    
    private func setup(){
        backgroundColor = .black
        delegate = self
        dataSource = self
        register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    private func activityIndicatorSetup(){
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
        activityIndicator.startAnimating()
    }
    
    // MARK: Delegate and DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topCoins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        let coin = viewModel.topCoins[indexPath.row]
        cell.configure(with: coin)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth / 2.5, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coinDelegate?.didSelectCoin(coin: viewModel.topCoins[indexPath.row], viewmodel: viewModel)
    }
    
}
