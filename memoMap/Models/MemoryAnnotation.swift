//
//  MemoryAnnotation.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/12/1.
//

import Foundation
import MapKit
import UIKit
import SwiftUI

class MemoryAnnotation: NSObject, MKAnnotation, Identifiable {
        var id: String
        var title: String?
        var subtitle: String?
        var coordinate: CLLocationCoordinate2D
        var isMemory: Bool
        var url: String
        var image: UIImage? = nil
        var color: UIColor?
        
      init(id: String, locAnnotation: LocationAnnotation, isMemory: Bool = false, url: String = "default.jpeg", image: UIImage, color: UIColor = UIColor.white) {
                self.id = id
                self.title = locAnnotation.title
                self.subtitle = locAnnotation.subtitle
                self.coordinate = locAnnotation.coordinate
                self.isMemory = isMemory
                self.url = url
                self.image = image
                self.color = color
            }
}
