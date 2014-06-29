//
//  GPointAnnotation.swift
//  gothere
//
//  Created by Alexey Konyakhin on 29/06/14.
//  Copyright (c) 2014 Alexey Konyakhin. All rights reserved.
//

import UIKit
import MapKit

class GPointAnnotation: MKPointAnnotation {
    var pointId: Int
    
    init (){
        pointId = 0
        super.init()
    }
}
