//
//  NSMutableAttributedString+Extension.swift
//  Doger
//
//  Created by Zura Kobakhidze on 21.12.21.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func text(_ text: String,
              font: UIFont? = nil,
              color: UIColor? = nil,
              bgColor: UIColor? = nil,
              underlineStyle: NSUnderlineStyle? = nil,
              underlineColor: UIColor? = nil,
              strikeStyle: NSNumber? = nil,
              strikeColor: UIColor? = nil) -> NSMutableAttributedString {
        
        let str = self
        let attr = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, attr.length)
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        attributes[.font] = font
        attributes[.foregroundColor] = color
        attributes[.underlineStyle] = underlineStyle?.rawValue
        attributes[.underlineColor] = underlineColor
        attributes[.strikethroughStyle] = strikeStyle
        attributes[.strikethroughColor] = strikeColor
        
        attr.addAttributes(attributes, range: range)
        str.append(attr)
        
        return str
        
    }
    
    func image(_ image: UIImage?) -> NSMutableAttributedString {
        
        let str = self
        let imageAttachment = NSTextAttachment()
        
        imageAttachment.image = image
        str.append(NSAttributedString(attachment: imageAttachment))
        
        return str
        
    }
    
}
