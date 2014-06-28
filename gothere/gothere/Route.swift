
import Foundation
import CoreData

@objc
class Route: _Route {

    class func routeWithID(routeID: String) -> Route? {
        let context = GTManagedObjectContext.mainContext
        let request = NSFetchRequest(entityName: Route.entityName())
        request.predicate = NSPredicate(format: "routeID == %@", routeID)
        var error: NSError?
        return context.executeFetchRequest(request, error: &error)[0] as? Route
    }

    class func routeFromJSONObject(JSONObject: AnyObject, inout error: NSError?) -> Route? {
        if let dictionary = JSONObject as? NSDictionary {
            if let roadID = dictionary["RoadId"] as? String {
                var route: Route! = routeWithID(roadID)
                if !route {
                    route = Route(managedObjectContext: GTManagedObjectContext.mainContext)
                    route.routeID = roadID
                }
                if let Dificult = dictionary["Dificult"] as? String {
                    route.difficulty = Dificult
                }
                if let Raiting = dictionary["Raiting"] as? String {
                    route.rating = Raiting
                }
                if let Name = dictionary["Name"] as? String {
                    route.name = Name
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
