//
//  CoreDataManager.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import PersistanceManager
import CoreData

/**
 * This singleton class that manages the core data activities
 */
final class CoreDataManager {

    private let sharedInststance: PersistanceManager

    private init() {
        let persistanceContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: CONFIG.MAIN_PERSISTANT_CONTAINER_NAME)
            container.loadPersistentStores { (_, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()

        sharedInststance = PersistanceManager(container: persistanceContainer)
    }

    static let shared = CoreDataManager().sharedInststance

}
