//
//  UIButton+Extension.swift
//  Good Weather
//
//  Created by TheGIZzz on 28/9/2565 BE.
//

import Foundation
import UIKit

extension UIButton {
    
    func makeButton(button: UIButton, systemName: String, text: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: systemName, withConfiguration: configuration)

        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.sizeToFit()
        
        self.setImage(image, for: .normal)
        self.imageView?.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit

        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
