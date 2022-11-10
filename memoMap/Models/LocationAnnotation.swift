//
//  LocationAnnotation.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import MapKit
import UIKit

class LocationAnnotation: NSObject, MKAnnotation {
    let name: String?
    let coordinate: CLLocationCoordinate2D
    
    init (location: Location) {
        self.name = location.name
        self.coordinate = location.coordinate
    }
    
}
