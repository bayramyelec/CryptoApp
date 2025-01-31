//
//  HomeTableView.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import UIKit

class HomeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel = HomeViewModel()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
        viewModel.reloadData = { [weak self] in
            self?.reloadData()
        }
        viewModel.fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        dataSource = self
        delegate = self
        backgroundColor = .black
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let coin = viewModel.coins[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row + 1)  \(coin.symbol) \(coin.name)"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
    
}
