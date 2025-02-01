//
//  HomeTableView.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import UIKit
import Kingfisher

class HomeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel = HomeViewModel()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
       
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
    
}
