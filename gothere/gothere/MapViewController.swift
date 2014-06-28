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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.delegate = self
        locManager.desiredAccuracy = 10
        locManager.distanceFilter = kCLDistanceFilterNone
        locManager.requestWhenInUseAuthorization()
        LoadingView.ShowLoadingView(self, show: true)
    }

    @IBAction func testLocPressed(sender : AnyObject) {
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locManager.startUpdatingLocation()
        map.showsUserLocation = true

//        BackendClient.instance.getRoutesListOnCompletion({ (routes: Route[]?, error: NSError?) -> () in
//            if routes {
//                NSLog("%@", routes.description)
//            }
//            else {
//                NSLog("%@", error.description)
//            }
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Choose a route >", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

