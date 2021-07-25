//
//  CoreDataManager.swift
//  Task
//
//  Created by Hemalatha K on 25/07/21.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation
import CoreData
class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {
        persistentContainer = NSPersistentContainer(name: "Task")
        persistentContainer.loadPersistentStores { (storDEsc, error) in
            
        }
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print("Core Data Save error", error)
            }
        }
    }
    
    func getAllValues() -> [ContentDataModel]? {
        let request: NSFetchRequest = ContentDataModel.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Core Data Fetch error", error)
            return []
        }
    }
    
    func deleteEntry() {
        let object = getAllValues()
        object?.forEach { context.delete($0) }
    }
}
