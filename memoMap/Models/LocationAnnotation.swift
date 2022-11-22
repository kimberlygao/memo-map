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
  
  
    init (title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }

}
