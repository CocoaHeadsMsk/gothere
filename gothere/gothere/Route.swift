
import Foundation
import CoreData

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
            if let roadShot = rootObject["RoadShot"] as? NSDictionary {
                if let roadID = roadShot["RoadId"] as? String {
                    var route: Route! = routeWithID(roadID)
                    if !route {
                        route = Route(managedObjectContext: GTManagedObjectContext.mainContext)
                        route.routeID = roadID
                    }
                    if let Dificult = roadShot["Dificult"] as? String {
                        route.difficulty = Dificult
                    }
                    if let Raiting = roadShot["Raiting"] as? String {
                        route.rating = Raiting
                    }
                    if let Name = roadShot["Name"] as? String {
                        route.name = Name
                    }
                    
                    return route
                }
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
                        if let route = routeFromJSONObject(roadShotObject, error: &error) {
                            routesList += route
                        }
                    }
                    result = routesList
                }
            }
        }

        return result
    }

}
