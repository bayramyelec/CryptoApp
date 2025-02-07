//
//  SettingsVC.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 6.02.2025.
//

// MARK: Holding Model

struct CoinAmount {
    var amount: Double
    var value: Double
}

import UIKit

class PortfolioVC: UIViewController {
    
    // MARK: Variables
    
    var coins: [Coin] = []
    var coinAmounts: [Int: CoinAmount] = [:]
    
    private let coinTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.text = "Coins"
        return label
    }()
    
    private let holdingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.text = "Holdings"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.text = "Price"
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    // MARK: Funcs
    
    private func setupUI(){
        view.backgroundColor = .black
        view.addSubview(coinTitleLabel)
        coinTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.equalToSuperview().inset(30)
        }
        view.addSubview(holdingsLabel)
        holdingsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
            make.left.equalTo(coinTitleLabel.snp.right)
        }
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.left.equalTo(holdingsLabel.snp.right)
            make.right.equalToSuperview().inset(30)
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: PortfolioTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(coinTitleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.reloadData()
    }
    
    private func setupNavigationBar(){
        CustomNavigationBar(backgroundColor: .black, tintColor: .white, title: "Portfolio")
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

// MARK: TableView Delegate and DataSource

extension PortfolioVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTableViewCell.identifier, for: indexPath) as! PortfolioTableViewCell
        let coin = coins[indexPath.row]
        let amount = coinAmounts[indexPath.row]
        cell.configure(with: coin, index: indexPath.row, amount: amount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.coin = coins[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            
            self.coins.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .systemRed
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
    
}
