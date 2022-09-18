//
//  HomeWeatherViewController.swift
//  Good Weather
//
//  Created by TheGIZzz on 25/8/2565 BE.
//

import UIKit

class HomeWeatherViewController: UIViewController {
    
    lazy private var gradientBackground: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 1, green: 1, blue: 0.867, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.835, blue: 0.898, alpha: 1).cgColor
        ]
        return gradientLayer
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
//        tableView.register(NewsHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier)
//        tableView.register(NewsStoryTableViewCell.self, forCellReuseIdentifier: NewsStoryTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }

    private func setupConstraints() {
        
        view.layer.addSublayer(gradientBackground)
    }
}

