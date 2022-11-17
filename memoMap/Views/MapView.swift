//
//  MapView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import MapKit

//class MapViewCoordinator: NSObject, MKMapViewDelegate {
//
//      var mapViewController: MapView
//
//      init(_ control: MapView) {
//          self.mapViewController = control
//      }
//
//      func mapView(_ mapView: MKMapView, viewFor
//           annotation: MKAnnotation) -> MKAnnotationView?{
//         //Custom View for Annotation
//          let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
//          annotationView.canShowCallout = true
//          //Your custom image icon
//          annotationView.image = UIImage(named: "locationPin")
//          return annotationView
//       }
//}

struct MapView: UIViewRepresentable {
    
  @ObservedObject var mapViewController: MapViewController
  @ObservedObject var searchController: SearchController
//  @ObservedObject var placeController: PlaceController
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
    var annotations = [MKPointAnnotation]()
    let mapView = MKMapView(frame: .zero)
//    func makeCoordinator() -> MapViewCoordinator {
//            MapViewCoordinator(self)
//        }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("updating")
        uiView.showsUserLocation = true
        uiView.annotations.forEach { uiView.removeAnnotation($0) }
//        mapViewController.current.loadLocation()
//        mapViewController.getNearbyLocations(using: MKLocalSearch.Request())
//        uiView.delegate = context.coordinator
        print("map annotations:", annotations)
        uiView.addAnnotations(annotations)
        uiView.showAnnotations(annotations, animated: true)
//        uiView.addAnnotations(searchViewController.searchAnnotations)
        print("added")
  }
    typealias UIViewType = MKMapView

//    mutating func getSearchResults () {
//        self.searchResults = searchViewController.getSearchResults()
//    }
    
    private func setUpMapRegion() {
        mapViewController.current.getCurrentLocation()
        let coordinate = CLLocationCoordinate2D(latitude: mapViewController.current.latitude, longitude: mapViewController.current.longitude
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
    }
    
    func makeUIView(context: Context) -> MKMapView {
      setUpMapRegion()
//      getSearchResults()
//        mapView.addAnnotations(searchViewController.searchAnnotations)
//
//      // TODO: figure out how to move to MapViewController
////      userLocation.loadLocation()
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
