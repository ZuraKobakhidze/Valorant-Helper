//
//  CrosshairCD.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 15.03.22.
//

import UIKit
import CoreData

@objc(CrosshairCD)
class CrosshairCD: NSManagedObject, ViewModel {
    @NSManaged var coverImage: String?
    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var date: Date?
}
