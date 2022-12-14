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
    @Published var nearbyPlaces: [String] = []
    @Published var nearbyLocationData : [MKMapItem] = []
    var searchRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    @Published var locationAnnotations : [LocationAnnotation] = []
    
    override init() {
        super.init()
    }
    
    func requestNearbyLocations() {
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: self.current.coordinate.latitude, longitude: self.current.coordinate.longitude)
        
      let req = MKLocalPointsOfInterestRequest(center: region.center, radius: 200.0)
        req.pointOfInterestFilter = MKPointOfInterestFilter(including: [.restaurant, .cafe, .fitnessCenter, .gasStation, .hospital, .hotel, .library, .museum, .nationalPark, .nightlife, .park, .police, .postOffice, .publicTransport, .school, .stadium, .university, .winery, .zoo])
        let search = MKLocalSearch(request: req)
        search.start { response, error in
            guard let response = response else {
                print(error as Any)
                return
            }
            self.nearbyPlaces = response.mapItems.map{$0.name ?? "no name"}
            self.nearbyLocationData = response.mapItems
            print("nearby location data: ", self.nearbyLocationData)
        }
    }
    
}
