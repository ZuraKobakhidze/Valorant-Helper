//
//  CoreDataManager.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 11.03.22.
//

import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get }
    func save(viewModel: ViewModel)
    func read() 
}
