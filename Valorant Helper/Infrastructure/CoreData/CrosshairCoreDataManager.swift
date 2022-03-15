//
//  CrosshairCoreDataManager.swift
//  Valorant Helper
//
//  Created by Zura Kobakhidze on 15.03.22.
//

import UIKit
import CoreData

class CrosshairCoreDataManager {
    
    func save(viewModel: ViewModel) {
        
        guard let vm = viewModel as? CrosshairDetailVMProtocol else { return }

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "CrosshairCD", in: context)

        let newLineUp = CrosshairCD(entity: entity!, insertInto: context)

        newLineUp.id = vm.item?.id
        newLineUp.date = Date()
        newLineUp.coverImage = vm.item?.coverImage
        newLineUp.name = vm.item?.name
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func read(completion: @escaping ((Result<[CrosshairCD], Error>) -> Void)) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CrosshairCD")

        do {
            let arr: NSArray = try context.fetch(request) as NSArray
            var crosshairItems = [CrosshairCD]()
            for item in arr {
                if let crosshairItem = item as? CrosshairCD {
                    crosshairItems.append(crosshairItem)
                }
            }
            completion(.success(crosshairItems.sorted { $0.date! > $1.date! }))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func ifExists(id: String, completion: @escaping ((Bool) -> Void)) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CrosshairCD")

        do {
            
            let arr: NSArray = try context.fetch(request) as NSArray
            
            for item in arr {
                if let crosshairItem = item as? CrosshairCD {
                    if crosshairItem.id == id {
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

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CrosshairCD")

        do {
            
            let arr: NSArray = try context.fetch(request) as NSArray
            
            for item in arr {
                if let crosshairItem = item as? CrosshairCD {
                    if crosshairItem.id == id {
                        context.delete(crosshairItem)
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
