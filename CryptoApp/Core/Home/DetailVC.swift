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
    
    // MARK: Variables
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
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
    
    private let lineChartView: LineChartView = {
        let chart = LineChartView()
        return chart
    }()
    
    private let currentPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Price"
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let marketCapTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Market Capitalization"
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rankTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rank"
        return label
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let volumeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Volume"
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var coin: Coin?
    var viewModel = HomeViewModel()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        configure()
        setupChart()
    }
    
    // MARK: SETUP
    
    private func setupUI(){
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerView)
        headerView.layer.cornerRadius = 10
        headerView.addSubview(imageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(priceLabel)
        headerView.addSubview(percentChangeLabel)
        contentView.addSubview(lineChartView)
        contentView.addSubview(currentPriceTitleLabel)
        contentView.addSubview(currentPriceLabel)
        contentView.addSubview(currentPriceChangeLabel)
        contentView.addSubview(marketCapTitleLabel)
        contentView.addSubview(marketCapLabel)
        contentView.addSubview(rankTitleLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(volumeTitleLabel)
        contentView.addSubview(volumeLabel)
        
        setupConstraints()
    }
    
    // MARK: CONSTRAINTS
    
    private func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.bottom.equalTo(rankLabel.snp.bottom).offset(10)
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.left.right.equalToSuperview().inset(10)
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
        lineChartView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(300)
        }
        currentPriceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineChartView.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
        }
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(currentPriceTitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
        }
        currentPriceChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(currentPriceLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(30)
        }
        marketCapTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineChartView.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(20)
        }
        marketCapLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapTitleLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(20)
        }
        rankTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(currentPriceChangeLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        rankLabel.snp.makeConstraints { make in
            make.top.equalTo(rankTitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(30)
        }
        volumeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapLabel.snp.bottom).offset(40)
            make.right.equalToSuperview().inset(20)
        }
        volumeLabel.snp.makeConstraints { make in
            make.top.equalTo(volumeTitleLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(20)
        }
    }
    
    // MARK: Funcs
    
    private func configure(){
        if let url = URL(string: coin?.logoUrl ?? "") {
            imageView.kf.setImage(with: url)
        }
        nameLabel.text = "\(coin?.name ?? "") (\(coin?.symbol ?? ""))"
        priceLabel.text = "$\(coin?.priceUsd ?? "")"
        percentChangeLabel.text = "\(coin?.percentChange24H ?? "")%"
        
        currentPriceLabel.text = "$\(coin?.priceUsd ?? "")"
        currentPriceChangeLabel.text = "\(coin?.percentChange24H ?? "")%"
        
        let formattedMarket = formatNumber(Double(coin?.marketCapUsd ?? "") ?? 0)
        marketCapLabel.text = "$\(formattedMarket)"
        rankLabel.text = "\(coin?.rank ?? 0)"
        
        let formattedVolume = formatNumber(Double(coin?.volume24 ?? 0))
        volumeLabel.text = "$\(formattedVolume)"
        
        if coin?.percentChange24H.first == "-" {
            percentChangeLabel.textColor = .red
            currentPriceChangeLabel.textColor = .red
        } else {
            percentChangeLabel.textColor = .green
            currentPriceChangeLabel.textColor = .green
        }
        
    }
    
    private func setupNavigationBar() {
        CustomNavigationBar(backgroundColor: .black, tintColor: .white, title: coin?.name ?? "Details")
    }
    
    
    private func setupChart(){
        
        lineChartView.delegate = self
        
        guard let coin = coin else { return }
        
        let percentChanges: [(label: String, value: Double)] = [
            ("1h", Double(coin.percentChange1H) ?? 0),
            ("24h", Double(coin.percentChange24H) ?? 0),
            ("7d", Double(coin.percentChange7D) ?? 0)
        ]
        
        var entries: [ChartDataEntry] = []
        
        for (index, value) in percentChanges.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: value.value)
            entries.append(entry)
        }
        
        let dataset = LineChartDataSet(entries: entries, label: "Percent Change (%)")
        dataset.colors = [.systemPurple]
        dataset.valueColors = [.white]
        dataset.valueFont = .systemFont(ofSize: 13, weight: .bold)
        dataset.circleColors = entries.map { $0.y >= 0 ? .green : .red }
        dataset.circleRadius = 8
        dataset.lineWidth = 2
        dataset.drawCirclesEnabled = true
        dataset.drawValuesEnabled = true
        dataset.mode = .cubicBezier
        
        let data = LineChartData(dataSet: dataset)
        lineChartView.data = data
        
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: percentChanges.map { $0.label })
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.granularity = 1
        lineChartView.xAxis.labelTextColor = .white
        
        lineChartView.leftAxis.labelTextColor = .white
        lineChartView.rightAxis.enabled = false
        
        lineChartView.legend.textColor = .white
        lineChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInOutBack)
        lineChartView.backgroundColor = .black
        
        
    }
    
    private func formatNumber(_ num: Double) -> String {
        let thousand = num / 1_000
        let million = num / 1_000_000
        let billion = num / 1_000_000_000
        
        if billion >= 1.0 {
            return String(format: "%.1fB", billion)
        } else if million >= 1.0 {
            return String(format: "%.1fM", million)
        } else if thousand >= 1.0 {
            return String(format: "%.1fK", thousand)
        } else {
            return String(format: "%.0f", num)
        }
    }
    
    
}
