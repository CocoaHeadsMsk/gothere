//
//  BackendClient.swift
//  gothere
//
//  Created by Nikolay Morev on 28.06.14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit

class BackendClient: NSObject {
    let baseURL = NSURL(string: "http://nikolays-macbook-pro.local:8081/")

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
        let task = session.dataTaskWithURL(NSURL(string: methodName, relativeToURL: baseURL), completionHandler: { (data: NSData!, response: NSURLResponse!, connectionError: NSError!) -> Void in

            let HTTPResponse = response as NSHTTPURLResponse
            var documentContents: AnyObject?
            var documentError: NSError?
            if !response || !data {
                documentError = connectionError
            }
            else if HTTPResponse.statusCode == 200 {
                documentError = NSError(domain: "BackendClientErrorDomain", code: HTTPResponse.statusCode, userInfo: nil)
            }
            else {
                documentContents = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: &documentError)
            }

            completionBlock(documentContents, documentError)
        })
        task.resume()
    }

    func getRoutesListOnCompletion(completionBlock: (Route[]?, NSError?) -> ()) {
        getJSONFromMethod("RoadListRequest", completionBlock: { (JSONObject: AnyObject!, error: NSError?) -> () in

            if JSONObject {
                var parseError: NSError?
                if let routes = Route.routesList(JSONObject, error: &parseError) {
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
