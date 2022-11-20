//
//  LocationAnnotation.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/16.
//

import Foundation
import MapKit
import UIKit
import SwiftUI

class LocationAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
//    var image: UIImage? = nil
//    var color: UIColor?
    
    //    init (location: Location) {
    //        self.name = location.name
    //        self.coordinate = location.coordinate
    ////    init (location: Location) {
    ////        self.name = location.name
    ////        self.coordinate = location.coordinate
    ////    }
//    override init() {
//        self.title = nil
//        self.subtitle = nil
//        self.coordinate = CLLocationCoordinate2D()
////        self.image = nil
////        self.color = UIColor.white
//    }
    init (title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

}
