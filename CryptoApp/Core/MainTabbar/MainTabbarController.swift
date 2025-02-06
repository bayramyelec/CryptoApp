//
//  MainTabbarController.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 6.02.2025.
//

import UIKit

class MainTabbarController: UITabBarController, UISearchBarDelegate {
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        return button
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.myDarkGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.square"), for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        searchBar.searchTextField.backgroundColor = .systemGray6
        searchBar.placeholder = "Search..."
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        return button
    }()
    
    private var isToggle: Bool = false
    
    var viewModel = MainTabbarViewModel()
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupButtonAndBackView()
        homeViewModel.filteredCoins = homeViewModel.coins
        homeViewModel.fetchCoins()
        homeViewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        closeKeyboard()
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setup(){
        
        let homeVC = UINavigationController(rootViewController: HomeVC())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let voidVC = UIViewController()
        voidVC.tabBarItem = UITabBarItem(title: "", image: UIImage(), tag: 1)
        
        let settingsVC = UINavigationController(rootViewController: PortfolioVC())
        settingsVC.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(systemName: "person"), tag: 2)
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .systemGray2
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        setViewControllers([homeVC, voidVC, settingsVC], animated: true)
        
        if let items = tabBar.items {
            items[1].isEnabled = false
        }
        
    }
    
    private func setupButtonAndBackView(){
        view.addSubview(plusButton)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        plusButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.height.equalTo(60)
        }
        
        view.addSubview(backView)
        let swipeTarget = UISwipeGestureRecognizer(target: self, action: #selector(closeView))
        swipeTarget.direction = .down
        backView.gestureRecognizers = [swipeTarget]
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
        
        backView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
        }
        
        backView.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth / 1.3)
        }
        
        backView.addSubview(collectionView)
        collectionView.isHidden = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainTabbarCollectionViewCell.self, forCellWithReuseIdentifier: MainTabbarCollectionViewCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth / 1.1)
            make.height.equalTo(70)
        }
        
        backView.addSubview(tableView)
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth / 1.1)
            make.height.equalTo(70)
        }
        
        backView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth / 2)
            make.height.equalTo(50)
        }
    }
    
    @objc func closeView(){
        isToggle = false
        if isToggle == false {
            UIView.animate(withDuration: 0.5) {
                self.backView.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.height.equalTo(0)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func plusButtonTapped(){
        isToggle = true
        if isToggle {
            UIView.animate(withDuration: 0.5) {
                self.backView.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.height.equalTo(400)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func closeButtonTapped(){
        isToggle = false
        if isToggle == false {
            UIView.animate(withDuration: 0.5) {
                self.backView.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.height.equalTo(0)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func addButtonTapped(){
        isToggle = false
        if isToggle == false {
            UIView.animate(withDuration: 0.5) {
                self.backView.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.height.equalTo(0)
                }
                self.view.layoutIfNeeded()
            }
            
            if let portfolioNav = self.viewControllers?[2] as? UINavigationController,
               let portfolioVC = portfolioNav.viewControllers.first as? PortfolioVC {
                portfolioVC.coins.append(contentsOf: viewModel.coins)
                portfolioVC.tableView.reloadData()
            }
            
            viewModel.coins.removeAll()
            collectionView.reloadData()
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            collectionView.isHidden = false
            tableView.isHidden = true
            
        } else {
            collectionView.isHidden = true
            tableView.isHidden = false
            homeViewModel.filterCoins(searchText: searchText)
        }
        collectionView.reloadData()
        tableView.reloadData()
    }
    
}


extension MainTabbarController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTabbarCollectionViewCell.identifier, for: indexPath) as! MainTabbarCollectionViewCell
        let coin = viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}


extension MainTabbarController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = homeViewModel.filteredCoins[indexPath.row]
        let url = URL(string: item.logoUrl)
        cell.imageView?.kf.setImage(with: url)
        cell.textLabel?.text = item.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Add") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            
            let selectedCoin = homeViewModel.filteredCoins[indexPath.row]
            viewModel.addCoin(selectedCoin)
            
            self.searchBar.text = ""
            self.searchBar.resignFirstResponder()
            tableView.isHidden = true
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            completionHandler(true)
        }
        
        editAction.backgroundColor = .systemPurple
        
        let config = UISwipeActionsConfiguration(actions: [editAction])
        config.performsFirstActionWithFullSwipe = false
        
        return config
        
    }
    
    
}


extension MainTabbarController {
    
    private func closeKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKey))
        backView.addGestureRecognizer(tap)
    }
    
    @objc func closeKey(){
        view.endEditing(true)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            UIView.animate(withDuration: 0.3) {
                self.backView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
            }
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.3) {
            self.backView.transform = .identity
        }
    }
    
}
