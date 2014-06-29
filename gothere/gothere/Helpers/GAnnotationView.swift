//
//  GAnnotationView.swift
//  gothere
//
//  Created by Alexey Konyakhin on 29/06/14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit
import MapKit

class GAnnotationView: MKAnnotationView {

    var routeId : Int
    
    init(frame: CGRect) {
        routeId = 0
        super.init(frame: frame)
    }
    
    init(coder aDecoder: NSCoder!) {
        routeId = 0
        super.init(coder: aDecoder)
    }
    
    init(annotation: MKAnnotation!, reuseIdentifier: String!){
        routeId = 0
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }

}
