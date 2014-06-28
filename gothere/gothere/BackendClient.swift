//
//  BackendClient.swift
//  gothere
//
//  Created by Nikolay Morev on 28.06.14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit

class BackendClient: NSObject {
    let baseURL = NSURL(string: "http://mediquest.me:8082/")

    class var instance: BackendClient {
        struct Instance {
            static let instance : BackendClient = BackendClient()
        }
        return Instance.instance
    }

    let session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

    init() {

    }

    func getJSONFromMethod(methodName: String, completionBlock: (AnyObject!, NSError?) -> ()) -> () {
        let URL = NSURL(string: methodName, relativeToURL: baseURL)
        let task = session.dataTaskWithURL(URL, completionHandler: { (data: NSData!, response: NSURLResponse!, connectionError: NSError!) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                let HTTPResponse = response as NSHTTPURLResponse
                var documentContents: AnyObject?
                var documentError: NSError?
                if let r = response {
                    
                }
                else {
                    NSLog("xxx")
                }
                if !response || !data {
                    documentError = connectionError
                }
                else if HTTPResponse.statusCode != 200 {
                    documentError = NSError(domain: "BackendClientErrorDomain", code: HTTPResponse.statusCode, userInfo: nil)
                }
                else {
                    documentContents = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &documentError)
                }

                completionBlock(documentContents, documentError)
            })
        })
        task.resume()
    }

    func getRoutesListOnCompletion(completionBlock: (Route[]?, NSError?) -> ()) {
        getJSONFromMethod("RoadListRequest", completionBlock: { (JSONObject: AnyObject!, error: NSError?) -> () in
            if JSONObject {
                var parseError: NSError?
                let routesOrNil = Route.routesList(JSONObject, error: &parseError)
                if let routes = routesOrNil {
                    GTManagedObjectContext.mainContext.saveOrDie()
                    completionBlock(routes, nil)
                }
                else {
                    completionBlock(nil, parseError)
                }
            }
            else {
                completionBlock(nil, error)
            }
        })
    }

    func getRouteDetails() {

    }

    func getStory() {

    }
}
