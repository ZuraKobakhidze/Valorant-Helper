//
//  UIImageView+Extension.swift
//  Doger
//
//  Created by Zura Kobakhidze on 21.12.21.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func loadImageFromURL(urlString: String) {
        
        let url = URL(string: urlString)
        
        self.sd_setImage(with: url) { (image, error, cacheType, url) -> Void in
            
            if let downLoadedImage = image {
                if cacheType == .none {
                    self.alpha = 0
                    self.image = downLoadedImage
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [weak self] in
                        self?.alpha = 1
                    }
                }
            }
            
        }
        
    }
    
    func loadBigImageFromURL(urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = AppColor.mediumRed.color
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
        
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        ])
        
        activityIndicator.startAnimating()
        
        let url = URL(string: urlString)
        
        self.sd_setImage(with: url) { (image, error, cacheType, url) -> Void in
            
            if let downLoadedImage = image {
                
                activityIndicator.stopAnimating()
                
                if cacheType == .none {
                    self.alpha = 0
                    self.image = downLoadedImage
                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [weak self] in
                        self?.alpha = 1
                    }
                }
                
            }
            
        }
        
    }
    
}
