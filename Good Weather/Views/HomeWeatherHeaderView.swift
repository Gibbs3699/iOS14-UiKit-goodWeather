//
//  HomeWeatherHeaderView.swift
//  Good Weather
//
//  Created by TheGIZzz on 18/9/2565 BE.
//

import UIKit

class HomeWeatherHeaderView: UIView {

    static let identifier = "HomeWeatherHeaderView"

    // MARK: - Private

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
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenitNext-DemiBold", size: 16)
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenitNext-DemiBold", size: 14)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.addSubview(cityLabel)
        containerView.addSubview(dateLabel)
        addSubview(containerView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cityLabel.frame = CGRect(x: 14, y: 0, width: frame.width-28, height: frame.height/2)
        dateLabel.frame = CGRect(x: 28, y: 0, width: frame.width-28, height: frame.height/2)
        containerView.frame = CGRect(x: 10, y: -20, width: frame.width-20, height: frame.height/1.3)

    }
    
    public func configure(with viewModel: String) {
        cityLabel.text = viewModel
    }
}


