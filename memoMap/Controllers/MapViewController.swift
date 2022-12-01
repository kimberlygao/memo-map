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
//    let clusterManager = ClusterManager()
    //    var pointOfInterestCategory = MKPointOfInterestCategory? { get set }
    
//    override func viewDidLoad() {
//        print("MAP VIEW CONTROLLER VIEW DID LOAD")
//        addExistingMemories()
//        super.viewDidLoad()
//    }
    
    override init() {
        super.init()
        print("MAP VIEW CONTROLLER INIT")
        addExistingMemories()
    }

    func addExistingMemories() {
        var current = [ImageAnnotation]()
        print("ADD EXISTING MEMORIES")
        let test_locations = [
            ["name": "Delainie Coffee", "latitude": 40.4288961, "longitude": -79.9807498, "url": "https://lh3.googleusercontent.com/p/AF1QipP5UAJ9UxBIImLai1GyUC-pqgojujTOA3wbG8zy=s1360-w1360-h1020"],
            ["name": "Bird on the Run South Side", "latitude": 40.4290, "longitude": -79.9809, "url": "https://lh3.googleusercontent.com/p/AF1QipMh6jy5fe15-DLAUVOeZLdqx0M9rZyX89PMeoh8=s1360-w1360-h1020"],
            ["name": "Insomnia Cookies", "latitude": 40.428620, "longitude": -79.980860, "url": "https://lh3.googleusercontent.com/p/AF1QipMFI1XRH__juMM5_GcnXcSU3vUFGto2077V8VTo=s1360-w1360-h1020"],
            ["name": "Bruegger's Bagels", "latitude": 40.428951, "longitude": -79.980377, "url": "https://lh3.googleusercontent.com/p/AF1QipMov_7PmP9uH2ZJh8CzVtQAHpU6xkEslaNgBbs=s1360-w1360-h1020"],
        ]
        print("HERE")
        for location in test_locations {
            print("location: ", location)
            let name = location["name"] as? String ?? ""
            let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
            let url = location["url"] as? String ?? ""
            let locAnnotation = LocationAnnotation(title: name, subtitle: "", coordinate: loc)
          let annotation = ImageAnnotation(id: UUID().uuidString, locAnnotation: locAnnotation, image: UIImage())
//            annotation.title = name
//            annotation.coordinate = loc
            annotation.url = url
//                annotation.image = loadImageFromURL(url)
            //            self.annotations.append(annotation)
            current.append(annotation)
//            clusterManager.add(annotation)
            //            self.mapView.addAnnotation(annotation)
        }
        self.currMemories = current
    }
        
        func getNearbyLocations(using searchRequest: MKLocalSearch.Request) {
            print("get nearby location")
            self.searchRegion = MKCoordinateRegion(center: self.current.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            searchRequest.region = self.searchRegion
            
            let localSearch = MKLocalSearch(request: searchRequest)
            localSearch.start{
                (resp, err) in
                if let err = err {
                    print("Failed local search", err)
                    return
                }
                //success
                self.nearbyPlaces = resp?.mapItems ?? []
                print("nearby places")
                print(self.nearbyPlaces)
                if let updatedRegion = resp?.boundingRegion {
                    self.searchRegion = updatedRegion
                }
            }
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
