//
//  Date+Extension.swift
//  Messenger
//
//  Created by Zura Kobakhidze on 15.11.21.
//

import Foundation

extension Date {
    
    func longDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
        
    }
    
    func time() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
        
    }
    
}
