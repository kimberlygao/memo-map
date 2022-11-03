//
//  MapView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  let viewController: ViewController
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    viewController.current.getCurrentLocation()
    let coordinate = CLLocationCoordinate2D(latitude: viewController.current.latitude, longitude: viewController.current.longitude
    )
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    uiView.setRegion(region, animated: true)
    uiView.showsUserLocation = true
  }

  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView(frame: .zero)
    
//    viewController.carLocation.loadLocation()
//    let droppedPin = MKPointAnnotation()
//       droppedPin.coordinate = CLLocationCoordinate2D(
//          latitude: viewController.carLocation.latitude,
//          longitude: viewController.carLocation.longitude
//       )
//       droppedPin.title = "Your Car is Here"
//       droppedPin.subtitle = "Look it's your car!"
//
//    mapView.addAnnotation(droppedPin)
    return mapView
  }
  
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
