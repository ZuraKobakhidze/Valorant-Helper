//
//  AppColor.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 22.02.22.
//

import UIKit

enum AppColor {
    
    case darkWhite
    case mediumWhite
    case lightWhite
    case extraBlack
    case darkBlack
    case mediumBlack
    case darkBlue
    case mediumBlue
    case darkBrown
    case mediumBrown
    case darkGreen
    case mediumGreen
    case darkRed
    case mediumRed
    
    var color: UIColor {
        switch self {
            case .darkWhite:
                return UIColor(hex: "ECE8E1")
            case .mediumWhite:
                return UIColor(hex: "F2F2F2")
            case .lightWhite:
                return UIColor(hex: "F9F9F9")
            case .extraBlack:
                return UIColor(hex: "111111")
            case .darkBlack:
                return UIColor(hex: "0F1923")
            case .mediumBlack:
                return UIColor(hex: "383E3A")
            case .darkBlue:
                return UIColor(hex: "314969")
            case .mediumBlue:
                return UIColor(hex: "5984BE")
            case .darkBrown:
                return UIColor(hex: "6B4832")
            case .mediumBrown:
                return UIColor(hex: "C08259")
            case .darkGreen:
                return UIColor(hex: "002F27")
            case .mediumGreen:
                return UIColor(hex: "00AE91")
            case .darkRed:
                return UIColor(hex: "AA1A33")
            case .mediumRed:
                return UIColor(hex: "FF274D")
        }
    }
    
}
