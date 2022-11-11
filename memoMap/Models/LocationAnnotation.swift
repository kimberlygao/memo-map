//
//  LocationAnnotation.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import MapKit
import UIKit
import SwiftUI
import Foundation

class LocationAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
//    var image: UIImage?
//    var color: UIColor?
    
//    override init() {
//        self.coordinate = CLLocationCoordinate2D()
//        self.name = ""
//        self.image = ""
//        self.color = UIColor.white
//    }
    
//    init (location: Location) {
//        self.name = location.name
//        self.coordinate = location.coordinate
//    }
    init (title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
