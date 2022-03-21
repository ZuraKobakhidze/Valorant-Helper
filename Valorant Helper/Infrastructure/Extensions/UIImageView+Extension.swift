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
    
}
