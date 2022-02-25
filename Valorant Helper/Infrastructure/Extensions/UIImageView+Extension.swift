//
//  UIImageView+Extension.swift
//  Doger
//
//  Created by Zura Kobakhidze on 21.12.21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func loadImageFromURL(urlString: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.image = cachedImage
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
                self?.alpha = 1
                self?.transform = CGAffineTransform.identity
            }
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }
            
            imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
            
            DispatchQueue.main.async { [weak self] in
                self?.alpha = 0
                self?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self?.image = downloadedImage
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
                    self?.alpha = 1
                    self?.transform = CGAffineTransform.identity
                }
            }
            
        }.resume()
        
    }
    
}
