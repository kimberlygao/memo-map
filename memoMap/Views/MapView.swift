//
//  MapView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import Foundation
import SwiftUI
import MapKit

/*
  Coordinator for using UIKit inside SwiftUI.
 */
class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
      var mapViewController: MapView
        
      init(_ control: MapView) {
          self.mapViewController = control
      }
        
      func mapView(_ mapView: MKMapView, viewFor
           annotation: MKAnnotation) -> MKAnnotationView?{
         //Custom View for Annotation
          let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
          annotationView.canShowCallout = true
          //Your custom image icon
          annotationView.image = UIImage(named: "locationPin")
          return annotationView
       }
}


struct MapView: UIViewRepresentable {
    
  @ObservedObject var mapViewController: MapViewController
  @ObservedObject var placeController: PlaceController
  @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(40.444230, -79.945530), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

//    private func addMapAnnotations(from mapView: MKMapView) {
//        let test_locations = [
//            ["name": "Delainie's Coffee", "latitude": 40.4288961, "longitude": -79.9807498,],
//            ["name": "Bird on the Run South Side", "latitude": 40.4290, "longitude": -79.9809],
//            ["name": "Insomnia Cookies", "latitude": 40.428620, "longitude": -79.980860],
//            ["name": "Bruegger's Bagels", "latitude": 40.428951, "longitude": -79.980377],
//        ]
//        for location in test_locations {
//            print("location: ", location)
//            let annotation = MKPointAnnotation()
//            annotation.title = location["name"] as? String
//
//            let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//            annotation.coordinate = loc
//            mapView.addAnnotation(annotation)
//            print("added")
//        }
//    }
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        print("updating")
        uiView.showsUserLocation = true
//        uiView.shows = true
//        mapViewController.current.loadLocation()
//        mapViewController.getNearbyLocations(using: MKLocalSearch.Request())
        uiView.delegate = context.coordinator
        uiView.addAnnotations(mapViewController.locationAnnotations)
  }


  func makeUIView(context: Context) -> MKMapView {
      let mapView = MKMapView(frame: .zero)
//      let mapView = mapViewController.mapView
//
//
//      // TODO: figure out how to move to MapViewController
////      userLocation.loadLocation()
//      mapViewController.current.getCurrentLocation()
//      let coordinate = CLLocationCoordinate2D(latitude: mapViewController.current.latitude, longitude: mapViewController.current.longitude
//      )
//      let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
//          let region = MKCoordinateRegion(center: coordinate, span: span)
//          mapView.setRegion(region, animated: true)
//
//      mapViewController.addMapAnnotations()
    return mapView
  }
}



//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
