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

    func requestWithMethodName(methodName: String, parameters: NSDictionary = [:]) -> NSURLRequest {
        var methodNameWithParameters = methodName
        if parameters.count > 0 {
            methodNameWithParameters += "?" + parameters.gtm_httpArgumentsString()
        }
        let URL = NSURL(string: methodNameWithParameters, relativeToURL: baseURL)
        let request = NSMutableURLRequest(URL: URL)

        return request
    }

    func getJSONWithRequest(request: NSURLRequest, completionBlock: (AnyObject!, NSError?) -> ()) -> () {
        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, connectionError: NSError!) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                var documentContents: AnyObject?
                var documentError: NSError?
                if let HTTPResponse = response as? NSHTTPURLResponse {
                    if HTTPResponse.statusCode != 200 {
                        documentError = NSError(domain: "BackendClientErrorDomain", code: HTTPResponse.statusCode, userInfo: nil)
                    }
                    else {
                        documentContents = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &documentError)
                    }
                }
                else {
                    documentError = connectionError
                }

                completionBlock(documentContents, documentError)
            })
        })
        task.resume()
    }

    func getJSONFromStub(stub: String, completionBlock: (AnyObject!, NSError?) -> ()) {
        let URL = NSBundle.mainBundle().URLForResource(stub, withExtension: "json")
        if !URL {
            completionBlock(nil, NSError.errorWithDomain("BackendClientErrorDomain", code: 0, userInfo: [ NSLocalizedDescriptionKey : "Stub not found" ]))
        }
        else {
            var readError: NSError?
            if let data = NSData.dataWithContentsOfURL(URL, options: NSDataReadingOptions(), error: &readError) {
                var JSONError: NSError?
                let JSONObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &JSONError)
                completionBlock(JSONObject, JSONError)
            }
            else {
                completionBlock(nil, readError)
            }
        }
    }

    func getRoutesListOnCompletion(completionBlock: (Route[]?, NSError?) -> ()) {
        let request = requestWithMethodName("RoadListRequest")
        getJSONWithRequest(request, completionBlock: { (JSONObject: AnyObject!, error: NSError?) -> () in
//        getJSONFromStub("RoadListRequest", completionBlock: { (JSONObject: AnyObject!, error: NSError?) -> () in
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

    func getRouteDetails(routeID: String, completionBlock: (Route?, NSError?) -> ()) {
        let request = requestWithMethodName("RoadDetailRequest", parameters: [ "Id" : routeID ])
        getJSONWithRequest(request, completionBlock: { (JSONObject: AnyObject!, error: NSError?) -> () in
//        getJSONFromStub("RoadDetailRequest_\(routeID)", completionBlock: { (JSONObject: AnyObject!, error: NSError?) -> () in
            if JSONObject {
                var parseError: NSError?
                if let route = Route.routeDetails(JSONObject, error: &parseError) {
                    GTManagedObjectContext.mainContext.saveOrDie()
                    completionBlock(route, nil)
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

    func getStory(pointID: String, completionBlock: (Point?, NSError?) -> ()) {
        let request = requestWithMethodName("StoryRequest", parameters: [ "Id" : pointID ])
        getJSONWithRequest(request, completionBlock: { (JSONObject: AnyObject!, error: NSError?) -> () in
            if JSONObject {
                var parseError: NSError?
                if let point = Point.pointDetails(JSONObject, error: &parseError) {
                    GTManagedObjectContext.mainContext.saveOrDie()
                    completionBlock(point, nil)
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

}
