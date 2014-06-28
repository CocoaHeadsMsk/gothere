//
//  GTPersistentStoreCoordinator.swift
//  gothere
//
//  Created by Nikolay Morev on 28.06.14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit
import CoreData

class GTPersistentStoreCoordinator: NSPersistentStoreCoordinator {
    class var mainCoordinator: GTPersistentStoreCoordinator {
        struct Instance {
            static let instance : GTPersistentStoreCoordinator = {
                let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")
                let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL);
                var coordinator = GTPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
                let storeURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)[0].URLByAppendingPathComponent("Model.sqlite")

                var error: NSError?
                if !coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ], error: &error) {
                    assert(false, "Error initializing Core Data")
                }

                return coordinator
            }()
        }
        return Instance.instance
    }
}
