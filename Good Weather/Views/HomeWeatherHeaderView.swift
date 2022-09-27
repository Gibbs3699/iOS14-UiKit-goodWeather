//
//  HomeWeatherHeaderView.swift
//  Good Weather
//
//  Created by TheGIZzz on 18/9/2565 BE.
//

import UIKit
import Lottie

class HomeWeatherHeaderView: UIView {

    static let identifier = "HomeWeatherHeaderView"

    // MARK: - Private
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.text = "London"
        return label
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.text = "United Kingdom"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenitNext-DemiBold", size: 14)
        label.text = "19 Sep 2022"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.secondarySystemFill.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.text = "Today"
        label.textAlignment = .center
        return label
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "20°C"
        label.textAlignment = .center
        return label
    }()
    
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.text = "Cloudy"
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let animationView: AnimationView = {
        let lottie = AnimationView()
        lottie.translatesAutoresizingMaskIntoConstraints = false
        return lottie
    }()
    
    private lazy var contentVerticalImageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempLabel, weatherInfoLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
//    private lazy var contentHorizontalImageStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [ animationView, contentVerticalImageStackView])
//        stackView.axis = .horizontal
//        stackView.spacing = 5
//        return stackView
//    }()
    
    private lazy var contentVerticalStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [cityLabel, countryLabel, dateLabel, spacer])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.addSubview(contentVerticalStackView)
        addSubview(containerView)
        
        addSubview(animationView)
//        addSubview(contentVerticalImageStackView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentVerticalStackView.frame = CGRect(x: 25, y: 10, width: frame.width-50, height: frame.height/2)
        containerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height/1.3)
        animationView.frame = CGRect(x: 25, y: contentVerticalStackView.frame.height/2, width: frame.width/1.5, height: contentVerticalStackView.frame.height/2)
//        contentVerticalImageStackView.frame = CGRect(x: animationView.frame.width-100, y: animationView.frame.height, width: 100, height: 100)
//        contentVerticalImageStackView.frame = CGRect(x: frame.width/2, y: frame.height/2, width: 100, height: 100)
    }
    
    func setUpAnimation(name: String) {
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .repeat(5)
        animationView.animationSpeed = 1
        animationView.play()
    }
    
    public func configure(with viewModel: CurrentWeatherViewModel) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        
        DispatchQueue.main.async { [weak self] in
            self?.setUpAnimation(name: viewModel.conditionName)
            self?.cityLabel.text = viewModel.cityName
            self?.countryLabel.text = viewModel.country
            self?.dateLabel.text = dateFormatter.string(from: date)
        }

    }
}


