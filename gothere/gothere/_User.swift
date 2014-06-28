// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.swift instead.

import CoreData

enum UserRelationships: String {
    case finishedRoutes = "finishedRoutes"
}

@objc(_User)
class _User: NSManagedObject {

    /// pragma mark - Class methods

    class func entityName () -> String {
        return "User"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    /// pragma mark - Life cycle methods

    init(entity: NSEntityDescription!, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _User.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    /// pragma mark - Properties

    /// pragma mark - Relationships

    @NSManaged
    var finishedRoutes: NSSet

    func finishedRoutesSet() -> NSMutableSet! {
        self.willAccessValueForKey("finishedRoutes")

        let result = self.mutableSetValueForKey("finishedRoutes")

        self.didAccessValueForKey("finishedRoutes")
        return result
    }

}

extension _User {

    func addFinishedRoutes(objects: NSSet) {
        self.finishedRoutesSet().unionSet(objects)
    }

    func removeFinishedRoutes(objects: NSSet) {
        self.finishedRoutesSet().minusSet(objects)
    }

    func addFinishedRoutesObject(value: Route!) {
        self.finishedRoutesSet().addObject(value)
    }

    func removeFinishedRoutesObject(value: Route!) {
        self.finishedRoutesSet().removeObject(value)
    }

}

