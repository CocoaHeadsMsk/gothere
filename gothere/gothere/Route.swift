
import Foundation
import CoreData
import CoreLocation
import MapKit

@objc(Route)
class Route: _Route {

    class func routeWithID(routeID: String) -> Route? {
        let context = GTManagedObjectContext.mainContext
        let request = NSFetchRequest(entityName: Route.entityName())
        request.predicate = NSPredicate(format: "routeID == %@", routeID)
        var error: NSError?
        if let results = context.executeFetchRequest(request, error: &error) {
            assert(results.count < 2, "Duplicate objects in DB")
            return results.count > 0 ? (results[0] as Route) : nil
        }
        else {
            assert(false, "Invalid request")
        }

        return nil
    }

    class func routeFromJSONObject(JSONObject: AnyObject, inout error: NSError?) -> Route? {
        if let rootObject = JSONObject as? NSDictionary {
            if let roadID = rootObject["RoadId"] as? String {
                var route: Route! = routeWithID(roadID)
                if !route {
                    route = Route(managedObjectContext: GTManagedObjectContext.mainContext)
                    route.routeID = roadID
                }
                if let Dificult = rootObject["Dificult"] as? NSNumber {
                    route.difficulty = Dificult
                }
                if let Raiting = rootObject["Raiting"] as? String {
                    route.rating = Raiting
                }
                if let Name = rootObject["Name"] as? String {
                    route.name = Name
                }
                if let CheckPoints = rootObject["CheckPoints"] as? AnyObject[] {
                    var points = Point[]()
                    for checkPoint : AnyObject in CheckPoints {
                        if let pointObject : AnyObject = (checkPoint as? NSDictionary)?["CheckPoint"] {
                            var parseError: NSError?
                            if let point = Point.pointFromJSONObject(pointObject, error: &parseError) {
                                points += point
                            }
                        }
                    }
                    route.points = NSOrderedSet(array: points, copyItems: false)
                }

                if let FinishedByUser = rootObject["FinishedByUser"] as? NSNumber {
                    route.finishedByUser = FinishedByUser
                }
                if let Points = rootObject["Points"] as? NSNumber {
                    route.pointsNum = Points
                }

                return route
            }
        }

        return nil
    }

    class func routesList(JSONObject: AnyObject, inout error: NSError?) -> Route[]? {
        var result: Route[]?
        if let rootObject = JSONObject as? NSDictionary {
            if let roadListRequest = rootObject["RoadListRequest"] as? NSDictionary {
                if let roadList = roadListRequest["RoadList"] as? AnyObject[]  {
                    var routesList = Route[]()
                    for roadShotObject : AnyObject in roadList {
                        if let roadShotRoot = roadShotObject as? NSDictionary {
                            if let roadShot = roadShotRoot["RoadShot"] as? NSDictionary {
                                if let route = routeFromJSONObject(roadShot, error: &error) {
                                    routesList += route
                                }
                            }
                        }
                    }
                    result = routesList
                }
            }
        }

        return result
    }

    class func routeDetails(JSONObject: AnyObject, inout error: NSError?) -> Route? {
        if let rootObject = JSONObject as? NSDictionary {
            if let RoadDetailRequest = rootObject["RoadDetailRequest"] as? NSDictionary {
                if let roadDetail : AnyObject = RoadDetailRequest["RoadDetail"]  {
                    var parseError: NSError?
                    if let route = routeFromJSONObject(roadDetail, error: &parseError) {
                        return route
                    }
                    else {
                        error = parseError
                    }
                }
            }
        }

        return nil
    }

    var mapRect: MKMapRect? {
        get {
            if points.count == 0 {
                return nil
            }
            else if let points = points.array as? Point[] {
                var minPoint = points[0].mapPoint
                var maxPoint = points[0].mapPoint
                for point in points {
                    let mapPoint = point.mapPoint
                    if mapPoint.x < minPoint.x || mapPoint.y < minPoint.y {
                        minPoint = mapPoint
                    }
                    if mapPoint.x > maxPoint.x || mapPoint.y > maxPoint.y {
                        maxPoint = mapPoint
                    }
                }

                return MKMapRect(origin: MKMapPoint(x: minPoint.x, y: minPoint.y), size: MKMapSize(width: maxPoint.x - minPoint.x, height: maxPoint.y - minPoint.y))
            }
            else {
                return nil
            }
        }
    }
}
