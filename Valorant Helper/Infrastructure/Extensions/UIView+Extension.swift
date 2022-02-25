//
//  UIView+Extension.swift
//  Doger
//
//  Created by Zura Kobakhidze on 28.12.21.
//

import UIKit

extension UIView {
    
    static var reusableIdentifer: String {
        get {
            return String(describing: self)
        }
    }
    
}
