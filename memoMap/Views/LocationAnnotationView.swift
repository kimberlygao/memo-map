//
//  LocationAnnotationView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import SwiftUI
import Foundation
import MapKit

class LocationAnnotationView: MKAnnotationView {
    var imageView: UIImageView!
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

            self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            self.addSubview(self.imageView)

            self.imageView.layer.cornerRadius = 5.0
            self.imageView.layer.masksToBounds = true
    }
    
    override var image: UIImage? {
            get {
                return self.imageView.image
            }

            set {
                self.imageView.image = newValue
            }
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
