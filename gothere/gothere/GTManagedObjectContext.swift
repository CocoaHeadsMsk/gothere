//
//  GTManagedObjectContext.swift
//  gothere
//
//  Created by Nikolay Morev on 28.06.14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit
import CoreData

class GTManagedObjectContext: NSManagedObjectContext {
    class var mainContext: GTManagedObjectContext {
        struct Instance {
            static let instance : GTManagedObjectContext = {
                var context = GTManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                context.persistentStoreCoordinator = GTPersistentStoreCoordinator.mainCoordinator

                return context
            }()
        }
        return Instance.instance
    }
}
