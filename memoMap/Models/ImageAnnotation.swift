//
//  ImageAnnotation.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/17.
//

import Foundation
import MapKit
import UIKit
import SwiftUI

class ImageAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var isMemory: Bool
    var url: String
    var image: UIImage? = nil
    var color: UIColor?
    
    //    init (location: Location) {
    //        self.name = location.name
    //        self.coordinate = location.coordinate
    ////    init (location: Location) {
    ////        self.name = location.name
    ////        self.coordinate = location.coordinate
    ////    }
    init(locAnnotation: LocationAnnotation) {
        self.title = locAnnotation.title
        self.subtitle = locAnnotation.subtitle
        self.coordinate = locAnnotation.coordinate
        self.isMemory = false
        self.url = "https://i.pinimg.com/originals/4f/5d/23/4f5d23170a65869ff7c210342516ad2c.jpg"
        self.image = nil
        self.color = UIColor.white
    }
//    override init() {
//        self.title = nil
//        self.subtitle = nil
//        self.coordinate = CLLocationCoordinate2D()
//        self.isMemory = false
//        self.url = "https://i.pinimg.com/originals/4f/5d/23/4f5d23170a65869ff7c210342516ad2c.jpg"
//        self.image = nil
//        self.color = UIColor.white
//    }
//    init (title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
//        self.title = title
//        self.subtitle = subtitle
//        self.coordinate = coordinate
//    }

}
