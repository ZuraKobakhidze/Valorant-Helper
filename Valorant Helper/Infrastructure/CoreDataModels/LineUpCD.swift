//
//  LineUpCD.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 14.03.22.
//

import UIKit
import CoreData

@objc(LineUpCD)
class LineUpCD: NSManagedObject, ViewModel {
    @NSManaged var date: Date?
    @NSManaged var id: String?
    @NSManaged var agentImage: String?
    @NSManaged var agentPath: String?
    @NSManaged var lineUpName: String?
    @NSManaged var lineUpPath: String?
    @NSManaged var mapIcon: String?
    @NSManaged var site: String?
}
