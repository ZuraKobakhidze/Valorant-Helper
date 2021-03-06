//
//  LineUpCoreDataManager.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 14.03.22.
//

import UIKit
import CoreData

class LineUpCoreDataManager {
    
    func save(viewModel: ViewModel) {
        
        guard let vm = viewModel as? LineUpDetailVMProtocol else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "LineUpCD", in: context)
        
        let newLineUp = LineUpCD(entity: entity!, insertInto: context)
        
        newLineUp.date = Date()
        newLineUp.id = vm.item?.id
        newLineUp.agentImage = vm.agentImage
        newLineUp.agentPath = vm.agentPath
        newLineUp.lineUpName = vm.lineUpIdentifier?.lineUpName
        newLineUp.lineUpPath = vm.lineUpIdentifier?.lineUpPath
        newLineUp.mapIcon = vm.mapIcon
        newLineUp.site = vm.site
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func read(completion: @escaping ((Result<[LineUpCD], Error>) -> Void)) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LineUpCD")
        
        do {
            let arr: NSArray = try context.fetch(request) as NSArray
            var lineUpItems = [LineUpCD]()
            for item in arr {
                if let lineUpItem = item as? LineUpCD {
                    lineUpItems.append(lineUpItem)
                }
            }
            completion(.success(lineUpItems.sorted { $0.date! > $1.date! }))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func ifExists(id: String, completion: @escaping ((Bool) -> Void)) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LineUpCD")

        do {
            
            let arr: NSArray = try context.fetch(request) as NSArray
            
            for item in arr {
                if let lineUpItem = item as? LineUpCD {
                    if lineUpItem.id == id {
                        completion(true)
                        return
                    }
                }
            }
            
            completion(false)
            return
            
        } catch {
            print(error.localizedDescription)
            completion(false)
            return
        }
        
    }
    
    func delete(id: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LineUpCD")

        do {
            
            let arr: NSArray = try context.fetch(request) as NSArray
            
            for item in arr {
                if let lineUpItem = item as? LineUpCD {
                    if lineUpItem.id == id {
                        context.delete(lineUpItem)
                        do {
                            try context.save()
                            return
                        } catch {
                            print(error.localizedDescription)
                            return
                        }
                    }
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
