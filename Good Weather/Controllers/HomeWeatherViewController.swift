//
//  HomeWeatherViewController.swift
//  Good Weather
//
//  Created by TheGIZzz on 25/8/2565 BE.
//

import UIKit

class HomeWeatherViewController: UIViewController {
    
    private let gradientBackground: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 1, green: 1, blue: 0.867, alpha: 1).cgColor,
            UIColor(red: 1, green: 0.835, blue: 0.898, alpha: 1).cgColor
        ]
        return gradientLayer
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(HomeWeatherTableViewCell.self, forCellReuseIdentifier: HomeWeatherTableViewCell.identifier)
        return tableView
    }()
    
    private let homeWeatherHeaderView: HomeWeatherHeaderView = {
        let homeWeatherHeaderView = HomeWeatherHeaderView()
        homeWeatherHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return homeWeatherHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setUpTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    /// Sets up tableview
    private func setUpTableView() {
        view.addSubview(tableView)
        
        tableView.tableHeaderView = UIView(
            frame: CGRect(x: 0, y: homeWeatherHeaderView.frame.height , width: view.frame.width, height: view.frame.height/1.5)
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.layer.addSublayer(gradientBackground)
        gradientBackground.frame = view.bounds
        
        view.addSubview(homeWeatherHeaderView)
        homeWeatherHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width/1.1, height: view.frame.height/1.3)
        homeWeatherHeaderView.center = view.center
    }
}

extension HomeWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeWeatherTableViewCell.identifier, for: indexPath)
        
        cell.textLabel?.text = "test"
        cell.backgroundColor = .clear
        return cell
    }
    
}

