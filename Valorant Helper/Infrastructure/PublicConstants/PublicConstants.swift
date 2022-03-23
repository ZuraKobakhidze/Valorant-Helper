//
//  PublicConstants.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 10.03.22.
//

import UIKit

public struct PublicConstants {
    public static let screenHeight = UIScreen.main.bounds.height
    public static let screenWidth = UIScreen.main.bounds.width
    public static var bottomPadding: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.bottom ?? 0
    }
    public static var topPadding: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
}
