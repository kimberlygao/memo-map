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
  
}
