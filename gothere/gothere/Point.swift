
import Foundation
import CoreData

@objc(Point)
class Point: _Point {

    class func pointWithID(pointID: String) -> Point? {
        let context = GTManagedObjectContext.mainContext
        let request = NSFetchRequest(entityName: Point.entityName())
        request.predicate = NSPredicate(format: "storyID == %@", pointID)
        var error: NSError?
        if let results = context.executeFetchRequest(request, error: &error) {
            assert(results.count < 2, "Duplicate objects in DB")
            return results.count > 0 ? (results[0] as Point) : nil
        }
        else {
            assert(false, "Invalid request")
        }

        return nil
    }

    class func pointFromJSONObject(JSONObject: AnyObject, inout error: NSError?) -> Point? {
        if let pointObject = (JSONObject as? NSDictionary)?["CheckPoint"] as? NSDictionary {
            let point = Point(managedObjectContext: GTManagedObjectContext.mainContext)

            if let title = pointObject["pointTitle"] as? String {
                point.pointTitle = title
            }
            if let url = pointObject["url"] as? String {
                point.pointURL = url
            }
            if let StoryId = pointObject["StoryId"] as? String {
                point.storyID = StoryId
            }
            if let GeoPoint = pointObject["GeoPoint"] as? NSDictionary {
                if let lat = GeoPoint["lat"] as? NSNumber {
                    point.latitude = lat
                }
                if let lon = GeoPoint["lon"] as? NSNumber {
                    point.longitude = lon
                }
            }

            return point
        }

        return nil
    }

}
