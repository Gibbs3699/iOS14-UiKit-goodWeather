//
//  HomeWeatherHeaderView.swift
//  Good Weather
//
//  Created by TheGIZzz on 28/9/2565 BE.
//

import UIKit

class HomeWeatherHeaderView: UIView {
    
    private let locationButton: UIButton = {
        let button = UIButton()
        button.makeButton(button: button, systemName: "mappin.circle.fill", text: "City")
        button.tintColor = .label
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25
        
        return button
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
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(locationButton)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: topAnchor),
            locationButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            locationButton.widthAnchor.constraint(equalToConstant: 100),
            locationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}

