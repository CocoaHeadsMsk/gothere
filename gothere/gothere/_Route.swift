// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Route.swift instead.

import CoreData

enum RouteAttributes: String {
    case difficulty = "difficulty"
    case finishedByUser = "finishedByUser"
    case name = "name"
    case pointsNum = "pointsNum"
    case rating = "rating"
    case routeID = "routeID"
}

enum RouteRelationships: String {
    case points = "points"
}

@objc(_Route)
class _Route: NSManagedObject {

    /// pragma mark - Class methods

    class func entityName () -> String {
        return "Route"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    /// pragma mark - Life cycle methods

    init(entity: NSEntityDescription!, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _Route.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    /// pragma mark - Properties

    @NSManaged
    var difficulty: NSNumber

    // func validateDifficulty(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var finishedByUser: NSNumber

    // func validateFinishedByUser(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var name: String

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var pointsNum: NSNumber

    // func validatePointsNum(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var rating: String

    // func validateRating(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var routeID: String

    // func validateRouteID(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    /// pragma mark - Relationships

    @NSManaged
    var points: NSOrderedSet

    func pointsSet() -> NSMutableOrderedSet! {
        self.willAccessValueForKey("points")

        let result = self.mutableOrderedSetValueForKey("points")

        self.didAccessValueForKey("points")
        return result
    }

}

extension _Route {

    func addPoints(objects: NSOrderedSet) {
        self.pointsSet().unionOrderedSet(objects)
    }

    func removePoints(objects: NSOrderedSet) {
        self.pointsSet().minusOrderedSet(objects)
    }

    func addPointsObject(value: Point!) {
        self.pointsSet().addObject(value)
    }

    func removePointsObject(value: Point!) {
        self.pointsSet().removeObject(value)
    }

}

