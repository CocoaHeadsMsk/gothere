//
//  ViewController.swift
//  gothere
//
//  Created by Alexey Konyakhin on 28/06/14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingView.ShowLoadingView(self, show: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapViewDidFinishRenderingMap(mapView: MKMapView!, fullyRendered: Bool){
       LoadingView.ShowLoadingView(self, show: false)
    }

}

