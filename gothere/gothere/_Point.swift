// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Point.swift instead.

import CoreData

enum PointAttributes: String {
    case about = "about"
    case latitude = "latitude"
    case longitude = "longitude"
    case photoURL = "photoURL"
    case pointID = "pointID"
}

enum PointRelationships: String {
    case route = "route"
}

@objc(_Point)
class _Point: NSManagedObject {

    /// pragma mark - Class methods

    class func entityName () -> String {
        return "Point"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    /// pragma mark - Life cycle methods

    init(entity: NSEntityDescription!, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _Point.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    /// pragma mark - Properties

    @NSManaged
    var about: String

    // func validateAbout(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var latitude: Double

    // func validateLatitude(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var longitude: Double

    // func validateLongitude(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var photoURL: String

    // func validatePhotoURL(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var pointID: Int32

    // func validatePointID(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    /// pragma mark - Relationships

    @NSManaged
    var route: Route

    // func validateRoute(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}

