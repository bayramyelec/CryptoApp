//
//  SettingsVC.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 6.02.2025.
//

import UIKit

class PortfolioVC: UIViewController {
    
    var coins: [Coin] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    var viewModel = PortfolioViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: PortfolioTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.reloadData()
    }
    
    private func setupNavigationBar(){
        CustomNavigationBar(backgroundColor: .black, tintColor: .white, title: "Portfolio")
    }
    
}

extension PortfolioVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PortfolioTableViewCell.identifier, for: indexPath) as! PortfolioTableViewCell
        let coin = coins[indexPath.row]
        cell.configure(with: coin, index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
