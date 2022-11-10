//
//  MapViewController.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import UIKit
import MapKit
import SwiftyJSON
//import FloatingPanel

class MapViewController: UIViewController, ObservableObject {
    let current : Location = Location()
    let locations: [Location] = []
    let mapView : MKMapView = MKMapView(frame: .zero)
    var annotations : [MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView.delegate = self
//        addMapAnnotations()
//        performSearch()
//        let noLocation = CLLocationCoordinate2D()
//        let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 200, longitudinalMeters: 200)
//        mapView.setRegion(viewRegion, animated: false)
//        mapView.showsUserLocation = true
//        let initialLocation = CLLocation(latitude: self.current.latitude, longitude: self.current.longitude)
//        print(initialLocation.coordinate.latitude, initialLocation.coordinate.longitude)
//        zoomMapOn(location: initialLocation)
//        let panel = FloatingPanelController()
//        panel.set(contentViewController: SearchViewController())
//        panel.addPanel(toParent: self)
    }
    
//    func displayLocations (locations: [Location]) {
//        for location in locations {
//            let annotation = MKPointAnnotation()
//            annotation.title = location.name
//
//            let loc = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//            annotation.coordinate = loc
//            mapView.addAnnotation(annotation )
//        }
//    }
    
//    fileprivate func performSearch() {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = "Apple"
//        request.region = mapView.region
//        let localSearch = MKLocalSearch(request: request)
//        localSearch.start{
//            (resp, err) in
//            if let err = err {
//                print("Failed local search", err)
//                return
//            }
//            //success
//            resp?.mapItems.forEach({
//                (mapItem) in print(mapItem.name ?? "")
//            })
//        }
//    }
//    fileprivate func addMapAnnotations() {
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
    
//    private func updateMapAnnotations(from mapView: MKMapView) {
//            // put all the nearby location annotations on the map
//            mapView.removeAnnotations(mapView.annotations)
//            let annotations = mapViewController.locations.map(LocationAnnotation.init)
//            mapView.addAnnotations(annotations)
//        }
    
    func performSearch(search: String) {
        self.mapView.removeAnnotations(mapView.annotations)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        request.region = self.mapView.region
        let localSearch = MKLocalSearch(request: request)
        localSearch.start{
            (resp, err) in
            if let err = err {
                print("Failed local search", err)
                return
            }
            //success
            resp?.mapItems.forEach({
                (mapItem) in print(mapItem.name ?? "")
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
            })
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }

    private let regionRadius: CLLocationDistance = 1000
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var locationManager = CLLocationManager()
    
    func checkLocationServiceAuthenticationStatus() {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension MapViewController : CLLocationManagerDelegate {
    
}
