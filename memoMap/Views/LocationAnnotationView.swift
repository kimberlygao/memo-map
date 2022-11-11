//
//  LocationAnnotationView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import SwiftUI
import Foundation
import MapKit

struct LocationMapAnnotationView: View {
    let accentColor = Color.blue
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "photo.circle")
                .resizable()
                .scaledToFit()
                .frame(width:30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .cornerRadius(36)
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width:10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .foregroundColor(accentColor)
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
    
}


//class LocationAnnotationView: MKAnnotationView {
//    var imageView: UIImageView!
//
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//
//            self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
//            self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//            self.addSubview(self.imageView)
//
//            self.imageView.layer.cornerRadius = 5.0
//            self.imageView.layer.masksToBounds = true
//    }
//
//    override var image: UIImage? {
//            get {
//                return self.imageView.image
//            }
//
//            set {
//                self.imageView.image = newValue
//            }
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//}
