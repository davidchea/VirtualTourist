//
//  DataController.swift
//  VirtualTourist
//
//  Created by David Chea on 09/06/2020.
//  Copyright © 2020 David Chea. All rights reserved.
//

import CoreData

struct DataController {
    
    // MARK: - Properties
    
    static let shared = DataController()
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VirtualTourist")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()

    // MARK: - Public methods
    
    /// Get the context.
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    /// Save the context.
    func saveContext() {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
