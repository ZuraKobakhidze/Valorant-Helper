//
//  UIImageView+Extension.swift
//  Doger
//
//  Created by Zura Kobakhidze on 21.12.21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func loadImageFromURL(urlString: String) {
        
        let url = URL(string: urlString)
        self.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.3)),
            ]
        )
        
    }
    
}
