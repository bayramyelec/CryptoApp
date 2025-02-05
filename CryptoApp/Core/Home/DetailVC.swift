//
//  DetailVC.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 3.02.2025.
//

import UIKit
import SnapKit
import Kingfisher
import Charts
import DGCharts

class DetailVC: UIViewController, ChartViewDelegate {
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.2)
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coin: Coin?
    var viewModel = HomeViewModel()
    
    private var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        configure()
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        view.addSubview(headerView)
        headerView.layer.cornerRadius = 10
        headerView.addSubview(imageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(priceLabel)
        headerView.addSubview(percentChangeLabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(160)
        }
        imageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(20)
            make.width.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(imageView.snp.right).offset(5)
            make.height.equalTo(30)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
        }
        percentChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func configure(){
        if let url = URL(string: coin?.logoUrl ?? "") {
            imageView.kf.setImage(with: url)
        }
        nameLabel.text = "\(coin?.name ?? "") (\(coin?.symbol ?? ""))"
        priceLabel.text = "$\(coin?.priceUsd ?? "")"
        percentChangeLabel.text = "\(coin?.percentChange24H ?? "")%"
        
        if coin?.percentChange24H.first == "-" {
            percentChangeLabel.textColor = .red
        } else {
            percentChangeLabel.textColor = .green
        }
        
    }
    
    private func setupNavigationBar() {
        CustomNavigationBar(backgroundColor: .black, tintColor: .white, title: coin?.name ?? "Details")
    }
    
}
