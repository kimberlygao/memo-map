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
    var name: String?
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    //    var image: UIImage?
    //    var color: UIColor?
    
    //    init (location: Location) {
    //        self.name = location.name
    //        self.coordinate = location.coordinate
    ////    init (location: Location) {
    ////        self.name = location.name
    ////        self.coordinate = location.coordinate
    ////    }
    init (title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

}
