
import CoreData

@objc(User)
class User: _User {

    class func currentUser() -> User {
        let context = GTManagedObjectContext.mainContext
        let request = NSFetchRequest(entityName: User.entityName())
        request.fetchLimit = 1
        var user: User?
        var error: NSError?
        if let results = context.executeFetchRequest(request, error: &error) {
            assert(results.count < 2, "Duplicate objects in DB")
            user = results.count > 0 ? (results[0] as User) : nil
        }
        else {
            assert(false, "Invalid request")
        }

        if !user {
            user = User(managedObjectContext: GTManagedObjectContext.mainContext)
        }

        return user!
    }

}
