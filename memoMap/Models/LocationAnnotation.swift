//
//  LocationAnnotation.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import MapKit
import UIKit

class LocationAnnotation: NSObject, MKAnnotation {
    var name: String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImage?
    var color: UIColor?
    
//    override init() {
//        self.coordinate = CLLocationCoordinate2D()
//        self.name = ""
//        self.image = ""
//        self.color = UIColor.white
//    }
    
    init (location: Location) {
        self.name = location.name
        self.coordinate = location.coordinate
    }
    
}
