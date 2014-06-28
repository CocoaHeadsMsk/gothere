
import Foundation

@objc(Point)
class Point: _Point {

    class func pointFromJSONObject(JSONObject: AnyObject, inout error: NSError?) -> Point? {
        if let rootObject = JSONObject as? NSDictionary {
            if let CheckPoint = rootObject["CheckPoint"] as? NSDictionary {
                let point = Point(managedObjectContext: GTManagedObjectContext.mainContext)

                if let url = CheckPoint["url"] as? String {
                    point.pointURL = url
                }
                if let StoryId = CheckPoint["StoryId"] as? String {
                    point.storyID = StoryId
                }
                if let GeoPoint = CheckPoint["GeoPoint"] as? NSDictionary {
                    if let lat = GeoPoint["lat"] as? NSNumber {
                        point.latitude = lat
                    }
                    if let lon = GeoPoint["lon"] as? NSNumber {
                        point.longitude = lon
                    }
                }

                return point
            }
        }

        return nil
    }

}
