//
//  MapViewController.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import UIKit
import MapKit
import Foundation
import Cluster


class MapViewController: NSObject, ObservableObject {
  let current : Location = Location()
  let locations: [Location] = []
  var mapView : MKMapView = MKMapView(frame: .zero)
  var nearbyPlaces: [MKMapItem] = []
  var searchRegion: MKCoordinateRegion = MKCoordinateRegion()
  @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
  @Published var locationAnnotations : [LocationAnnotation] = []
  @Published var currMemories = [ImageAnnotation]()
  
  override init() {
    super.init()
  }
  
  
  func getNearbyLocations(using searchRequest: MKLocalSearch.Request) -> [String] {
    self.searchRegion = MKCoordinateRegion(center: self.current.coordinate, latitudinalMeters: 5, longitudinalMeters: 5)
    searchRequest.region = self.searchRegion
    searchRequest.naturalLanguageQuery = "Restaurants"
    
    let localSearch = MKLocalSearch(request: searchRequest)
    localSearch.start{
      (resp, err) in
      if let err = err {
        print("Failed local search", err)
        return
      }
      //success
      self.nearbyPlaces = resp?.mapItems ?? []
      if let updatedRegion = resp?.boundingRegion {
        self.searchRegion = updatedRegion
      }
    }
    
    return self.nearbyPlaces.map{$0.name ?? "no name"}
  }
  
  
  //    private func updateMapAnnotations(from mapView: MKMapView) {
  //            // put all the nearby location annotations on the map
  //            mapView.removeAnnotations(mapView.annotations)
  //            let annotations = mapViewController.locations.map(LocationAnnotation.init)
  //            mapView.addAnnotations(annotations)
  //        }
}


//        private let regionRadius: CLLocationDistance = 1000
//        func zoomMapOn(location: CLLocation)
//        {
//            let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//            mapView.setRegion(coordinateRegion, animated: true)
//        }
//
//        func checkLocationServiceAuthenticationStatus() {
//            locationManager.delegate = self
//            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//                mapView.showsUserLocation = true
//            } else {
//                locationManager.requestWhenInUseAuthorization()
//            }
//        }

extension MapViewController : CLLocationManagerDelegate {
  
}
