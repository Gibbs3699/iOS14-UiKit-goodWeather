//
//  HomeWeatherContentView.swift
//  Good Weather
//
//  Created by TheGIZzz on 18/9/2565 BE.
//

import UIKit
import Lottie

class HomeWeatherContentView: UIView {

    // MARK: - Private
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.text = "London"
        label.textColor = .black
        return label
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.text = "United Kingdom"
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenitNext-DemiBold", size: 14)
        label.text = "19 Sep 2022"
        label.textColor = .black
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
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
        label.textColor = .black
        return label
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "20°C"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.text = "Cloudy"
        label.textAlignment = .center
        label.textColor = .gray
        label.textColor = .black
        return label
    }()
    
    private let animationView: AnimationView = {
        let lottie = AnimationView()
        lottie.animation = Animation.named("sun")
        return lottie
    }()
    
    private lazy var contentVerticalImageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempLabel, weatherInfoLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var contentHorizontalImageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ animationView,  contentVerticalImageStackView])
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var spacer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var contentVerticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityLabel, countryLabel, dateLabel, contentHorizontalImageStackView, spacer])
        stackView.axis = .vertical
        stackView.setCustomSpacing(20, after: dateLabel)
        stackView.spacing = 16
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        contentVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(contentVerticalStackView)
        addSubview(containerView)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant:  UIScreen.main.bounds.width-40),
            containerView.heightAnchor.constraint(equalToConstant:  UIScreen.main.bounds.height/1.8),
            
            contentVerticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            contentVerticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            contentVerticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            contentVerticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            
            animationView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
            animationView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3.5),
        ])
        
        tempLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func setUpAnimation(name: String) {
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }
    
    public func configure(with viewModel: CurrentWeatherViewModel) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        
        DispatchQueue.main.async { [weak self] in
            self?.cityLabel.text = viewModel.cityName
            self?.countryLabel.text = viewModel.country
            self?.dateLabel.text = dateFormatter.string(from: date)
            self?.setUpAnimation(name: viewModel.conditionName)
        }

    }
}


