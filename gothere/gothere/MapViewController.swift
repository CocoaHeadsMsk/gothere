//
//  ViewController.swift
//  gothere
//
//  Created by Alexey Konyakhin on 28/06/14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let locManager = CLLocationManager()

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var map : MKMapView
    @IBOutlet var routeChoosingButton: UIButton
    var showRoute = false

    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.delegate = self
        locManager.desiredAccuracy = 10
        locManager.distanceFilter = kCLDistanceFilterNone
        locManager.requestWhenInUseAuthorization()
        LoadingView.ShowLoadingView(self, show: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locManager.startUpdatingLocation()
        map.showsUserLocation = !showRoute

//        BackendClient.instance.getStory("4", completionBlock: { (point: Point?, error: NSError?) -> () in
//            if point {
//                NSLog("%@", point.description)
//            }
//            else {
//                NSLog("%@", error.description)
//            }
//        })

        BackendClient.instance.getRoutesListOnCompletion({ (routes: Route[]?, error: NSError?) -> () in
            if routes && self.showRoute {
                NSLog("%@", routes.description)

                BackendClient.instance.getRouteDetails("1", { (route: Route?, error: NSError?) in
                    if route {
                        NSLog("%@", route.description)
                        NSLog("%@", route!.points.description)
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                self.showAnnotationsFromSet(route!.points)
                            }
                        }
                    }
                    else {
                        NSLog("%@", error.description)
                    }
                })
            }
            else {
                NSLog("%@", error.description)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAnnotationsFromSet(set : NSOrderedSet){
        for idx in 0..set.count {
            var point = set.objectAtIndex(idx) as Point
            var coord = CLLocationCoordinate2DMake(point.latitude.doubleValue, point.longitude.doubleValue)
            var annotation = GPointAnnotation()
            annotation.setCoordinate(coord)
            annotation.title = point.pointTitle
            annotation.pointId = point.storyID
            map.addAnnotation(annotation)
            map.setRegion(MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.3, 0.3)), animated: true)
        }
    }
    
    func mapViewDidFinishRenderingMap(mapView: MKMapView!, fullyRendered: Bool){
       LoadingView.ShowLoadingView(self, show: false)
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.NotDetermined) {
            locManager.requestWhenInUseAuthorization()
            map.showsUserLocation = true
            println("Auth status unknown...");
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!{
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        var aview = GAnnotationView(annotation: annotation, reuseIdentifier: "defAnnotId")
        aview.canShowCallout = true
        var butt = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        butt.addTarget(self, action: "calloutTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        aview.rightCalloutAccessoryView = butt as UIView
        aview.image = UIImage(named: "pin.png")
        return aview
    }
    
    func calloutTapped(sender:UIButton!){
        
    }

    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!){
        //stub
        if ((view as GAnnotationView).annotation as GPointAnnotation).pointId == ""{
            println("1")
        }
    }

    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:AnyObject[]) {

        if map.userLocation.location {
            map.setRegion(MKCoordinateRegion(center: map.userLocation.location.coordinate, span: MKCoordinateSpanMake(0.05, 0.05)), animated: true)
            var gc = CLGeocoder()
            gc.reverseGeocodeLocation(map.userLocation.location, completionHandler:
                { (response: AnyObject[]!, error: NSError!) -> Void in
                    var plArray : NSArray
                    var placemark : CLPlacemark
                    plArray = response as NSArray
                    placemark = plArray.objectAtIndex(0) as CLPlacemark
                    locManager.stopUpdatingLocation()
                    self.showAlertWithMessage(
                      "You are here: " +  placemark.locality + ", " +  placemark.country)
                }
            )
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    func showAlertWithMessage(message: NSString){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.routeChoosingButton.hidden = false
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {

    }

}
