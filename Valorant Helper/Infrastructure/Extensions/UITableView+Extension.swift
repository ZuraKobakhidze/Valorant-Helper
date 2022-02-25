//
//  UITableView+Extension.swift
//  Doger
//
//  Created by Zura Kobakhidze on 24.12.21.
//

import UIKit

extension UITableView {
    
    func layoutHeader() {
        guard let view = tableHeaderView else { return }
        let fittingSize = CGSize(width: frame.size.width, height: 0)
        let size = view.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        view.frame = CGRect(origin: .zero, size: size)
        tableHeaderView = view
    }
    
    func layoutFooter() {
        guard let view = tableFooterView else { return }
        let fittingSize = CGSize(width: frame.size.width, height: 0)
        let size = view.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        view.frame = CGRect(origin: .zero, size: size)
        tableFooterView = view
    }
    
}
