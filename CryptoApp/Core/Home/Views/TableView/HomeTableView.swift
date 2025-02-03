//
//  HomeTableView.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import UIKit
import Kingfisher

final class HomeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel = HomeViewModel()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
        activityIndicatorSetup()
        viewModel.fetchCoins()
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        dataSource = self
        delegate = self
        backgroundColor = .black
        register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    private func activityIndicatorSetup(){
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
        activityIndicator.startAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        let coin = viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
