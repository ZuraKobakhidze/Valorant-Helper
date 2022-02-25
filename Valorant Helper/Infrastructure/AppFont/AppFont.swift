//
//  AppFont.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 22.02.22.
//

import Foundation
import UIKit

class AppFont {
    
    static func getBold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func getExtraLight(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-ExtraLight", size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
    }
    
    static func getLight(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    static func getMedium(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func getRegular(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func getSemiBold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "Oswald-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func getVALORANT(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "VALORANT-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
}
