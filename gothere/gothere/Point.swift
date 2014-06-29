
import Foundation
import CoreData
import CoreLocation
import MapKit

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
        if let pointObject = JSONObject as? NSDictionary {
            if let StoryId = pointObject["StoryId"] as? String {
                var point: Point! = pointWithID(StoryId)
                if !point {
                    point = Point(managedObjectContext: GTManagedObjectContext.mainContext)
                    point.storyID = StoryId
                }

                if let title = pointObject["pointTitle"] as? String {
                    point.pointTitle = title
                }
                if let title = pointObject["Title"] as? String {
                    point.pointTitle = title
                }
                if let url = pointObject["url"] as? String {
                    point.pointURL = url
                }
                if let GeoPoint = pointObject["GeoPoint"] as? NSDictionary {
                    if let lat = GeoPoint["lat"] as? NSNumber {
                        point.latitude = lat
                    }
                    if let lon = GeoPoint["lon"] as? NSNumber {
                        point.longitude = lon
                    }
                }
                if let Description = pointObject["Description"] as? String {
                    point.about = Description
                }
                if let PhotoDescriptionUrl = pointObject["PhotoDescriptionUrl"] as? String {
                    point.photoURL = PhotoDescriptionUrl
                }
                
                return point
            }
        }

        return nil
    }

    class func pointDetails(JSONObject: AnyObject, inout error: NSError?) -> Point? {
        if let pointObject = ((JSONObject as? NSDictionary)?["StoryRequest"] as? NSDictionary)?["Story"] as? NSDictionary {
            var parseError: NSError?
            if let point = Point.pointFromJSONObject(pointObject, error: &parseError) {
                return point
            }
        }

        return nil
    }

    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue)
        }
    }

    var mapPoint: MKMapPoint {
        get {
            return MKMapPointForCoordinate(coordinate)
        }
    }

}
