//
//  CustomNavigationBar.swift
//  CryptoApp
//
//  Created by Bayram Yeleç on 31.01.2025.
//

import UIKit

extension UIViewController {
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func CustomNavigationBar(backgroundColor: UIColor, tintColor: UIColor, title: String) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: tintColor]
        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.shadowColor = nil
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title
    }
    
    func circleButton(imageName: String, cornerRadius: CGFloat) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = cornerRadius
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return UIBarButtonItem(customView: button)
    }
    
    
}
