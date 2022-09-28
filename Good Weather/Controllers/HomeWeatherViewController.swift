//
//  HomeWeatherViewController.swift
//  Good Weather
//
//  Created by TheGIZzz on 25/8/2565 BE.
//

import UIKit
import CoreLocation

class HomeWeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    private let background: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.604, green: 1, blue: 0.62, alpha: 1).cgColor,
            UIColor(red: 0.266, green: 0.553, blue: 0.983, alpha: 1).cgColor
        ]
        return gradientLayer
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(HomeWeatherTableViewCell.self, forCellReuseIdentifier: HomeWeatherTableViewCell.identifier)
        return tableView
    }()
    
    private let homeWeatherContentView: HomeWeatherContentView = {
        let homeWeatherContentView = HomeWeatherContentView()
        homeWeatherContentView.translatesAutoresizingMaskIntoConstraints = false
        return homeWeatherContentView
    }()
    
    private let homeWeatherHeaderView: HomeWeatherHeaderView = {
        let homeWeatherHeaderView = HomeWeatherHeaderView()
        homeWeatherHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return homeWeatherHeaderView
    }()
    
    private var locationManager = CLLocationManager()
    private var currentLoc: CLLocation?
    private var latitude : CLLocationDegrees!
    private var longitude: CLLocationDegrees!
    
    let userDefaults =  UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupViews()
        setUpTableView()
        setupCoreLocation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupCoreLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setupSearchController() {
        let searchVC = UISearchController()
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        
        let location = locations[0].coordinate
        latitude = location.latitude
        longitude = location.longitude
        
        let userDefaults =  UserDefaults.standard
        userDefaults.set(latitude, forKey: "lat")
        userDefaults.set(longitude, forKey: "lon")
        
        fetchCurrentCoordinates(lat: latitude.description, lon: longitude.description)
    
    }
    
    private func fetchCurrentCoordinates(lat: String, lon: String) {
        APICaller.share.getCurrentLocationWeather(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.homeWeatherContentView.configure(with: CurrentWeatherViewModel(conditionId: weather.weather[0].id, cityName: weather.name, temperature: weather.main.temp, humidity: weather.main.humidity, conditionDescription: weather.weather[0].description, country: weather.sys.country))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        
        tableView.tableHeaderView = UIView(
            frame: CGRect(x: 0, y: homeWeatherHeaderView.frame.height , width: view.frame.width, height: view.frame.height/1.5)
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.layer.addSublayer(background)
        background.frame = view.bounds
        
        view.addSubview(homeWeatherHeaderView)
        view.addSubview(homeWeatherContentView)
        
        NSLayoutConstraint.activate([
            homeWeatherHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            homeWeatherHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            homeWeatherHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            homeWeatherHeaderView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40),
            homeWeatherHeaderView.heightAnchor.constraint(equalToConstant: 50) ,
            
            homeWeatherContentView.topAnchor.constraint(equalTo: homeWeatherHeaderView.bottomAnchor, constant: 20),
            homeWeatherContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeWeatherContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
}

extension HomeWeatherViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
    
        print("current query --> \(query)")
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

