//
//  String+Extension.swift
//  BoredAndMakingSomeWork
//
//  Created by Zura Kobakhidze on 11.02.22.
//

import Foundation

extension String {
    
    func localized() -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
    
}
