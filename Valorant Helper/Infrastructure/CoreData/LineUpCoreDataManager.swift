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
        
        newLineUp.id = UUID()
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
            completion(.success(lineUpItems))
        } catch {
            completion(.failure(error))
        }
        
    }
    
}
