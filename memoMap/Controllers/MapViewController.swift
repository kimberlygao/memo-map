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
import SwiftUI


//protocol MemoryDelegate {
//    func getMemoryPinsForUser(user: User) -> [ImageAnnotation]
//    func getCurrentUser() -> User
//}

class MapViewController: NSObject, ObservableObject {
    
//    var delegate: MemoryDelegate!
    
    @Published var current : Location = Location()
    let locations: [Location] = []
//    var mapView : MKMapView = MKMapView(frame: .zero)
    var nearbyPlaces: [MKMapItem] = []
    @Published var searchRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var locationAnnotations : [LocationAnnotation] = []
    @Published var currMemories = [ImageAnnotation]()
    @Published var ownView : Bool = true
    let interestPoints: [String] = ["restaurant", "cafe", "university", "park", "museum", "nightlife"]
    //    let clusterManager = ClusterManager()
    //    var pointOfInterestCategory = MKPointOfInterestCategory? { get set }
    
//        override func viewDidAppear  {
//            super.viewDidLoad()
//            addExistingMemories()
//        }
    
    override init() {
        super.init()
    }
    
    func toggleView() {
        self.ownView.toggle()
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("view did load!!")
////        self.dismiss(animated: true) {
////            self.addExistingMemories()
////        }
//        addExistingMemories()
//        print("curr mems added:", self.currMemories)
////        addExistingMemories()
//    }
    
//    dismiss(animated: true, completion: {
//        func viewWillAppear(_ animated: Bool) {
//            print("view did appear!!!")
//        }
//    })
    
    
//    private var observer: AnyObject!
//        override init() {
//            super.init()
//            print("MAP VIEW CONTROLLER INIT")
////            observer = NotificationCenter.default.addObserver(
////                forName: UIApplication.didBecomeActiveNotification,
////                object: nil,
////                queue: .main) { _ in
////                    self.addExistingMemories()
////                }
//            addExistingMemories()
//        }
//    override func viewDidLoad() {
//        print("vieew did load")
//        super.viewDidLoad()
//        observer = NotificationCenter.default.addObserver(
//            forName: UIApplication.didBecomeActiveNotification,
//            object: nil,
//            queue: .main) { _ in
//                self.addExistingMemories()
//            }
//    }
    
//    func addExistingMemories() {
//            var current = [ImageAnnotation]()
//            print("ADD EXISTING MEMORIES")
//            let test_locations = [
//                ["name": "Delainie Coffee", "latitude": 40.4288961, "longitude": -79.9807498, "url": "https://lh3.googleusercontent.com/p/AF1QipP5UAJ9UxBIImLai1GyUC-pqgojujTOA3wbG8zy=s1360-w1360-h1020"],
//                ["name": "Bird on the Run South Side", "latitude": 40.4290, "longitude": -79.9809, "url": "https://lh3.googleusercontent.com/p/AF1QipMh6jy5fe15-DLAUVOeZLdqx0M9rZyX89PMeoh8=s1360-w1360-h1020"],
//                ["name": "Insomnia Cookies", "latitude": 40.428620, "longitude": -79.980860, "url": "https://lh3.googleusercontent.com/p/AF1QipMFI1XRH__juMM5_GcnXcSU3vUFGto2077V8VTo=s1360-w1360-h1020"],
//                ["name": "Bruegger's Bagels", "latitude": 40.428951, "longitude": -79.980377, "url": "https://lh3.googleusercontent.com/p/AF1QipMov_7PmP9uH2ZJh8CzVtQAHpU6xkEslaNgBbs=s1360-w1360-h1020"],
//            ]
//            print("HERE")
//            for location in test_locations {
//                print("location: ", location)
//                let name = location["name"] as? String ?? ""
//                let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//                let url = location["url"] as? String ?? ""
//                let locAnnotation = LocationAnnotation(title: name, subtitle: "", coordinate: loc)
//              let annotation = ImageAnnotation(id: UUID().uuidString, locAnnotation: locAnnotation, image: UIImage())
//    //            annotation.title = name
//    //            annotation.coordinate = loc
//                annotation.url = url
//    //                annotation.image = loadImageFromURL(url)
//                //            self.annotations.append(annotation)
//                current.append(annotation)
//    //            clusterManager.add(annotation)
//                //            self.mapView.addAnnotation(annotation)
//            }
//            self.currMemories = current
//        }
    
    func addExistingMemories() {
//        var current = [ImageAnnotation]()
        print("ADD EXISTING MEMORIES")
//        print("delegate is: ", self.delegate)
//        let user = self.delegate?.getCurrentUser()
//        print("current user: ", user)
//        let test_locations = self.delegate?.getMemoryPinsForUser(user: user!)
//        print("test locations: ", test_locations)
        print("HERE")



//        for annotation in test_locations {
//            print("location: ", annotation)
////            let name = location["name"] as? String ?? ""
////            let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
////            let url = location["url"] as? String ?? ""
//
////            let name = location.title
////            let loc = location.coordinate
////
////            let locAnnotation = LocationAnnotation(title: name, subtitle: "", coordinate: loc)
////          let annotation = ImageAnnotation(id: UUID().uuidString, locAnnotation: locAnnotation, image: UIImage())
////            annotation.isMemory = true
//            annotation.isMemory = true
////            annotation.title = name
////            annotation.coordinate = loc
////            annotation.url = url
////                annotation.image = loadImageFromURL(url)
//            //            self.annotations.append(annotation)
////            current.append(annotation)
////            clusterManager.add(annotation)
//            //            self.mapView.addAnnotation(annotation)
//        }
//        for location in test_locations {
//                let url = location["url"] as? String ?? ""
//                let request = NSMutableURLRequest(url: URL(string: url)!)
//                request.httpMethod = "GET"
//                let session = URLSession(configuration: URLSessionConfiguration.default)
//                let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
//                    if error == nil {
//                        let name = location["name"] as? String ?? ""
//                        let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//                        let locAnnotation = LocationAnnotation(title: name, subtitle: "", coordinate: loc)
//
//                        //                        annotation.coordinate = memory.coordinate
//                        let image = UIImage(data: data!, scale: UIScreen.main.scale)
//                        let annotation = ImageAnnotation(id: UUID().uuidString, locAnnotation: locAnnotation, image: image ?? UIImage())
//                        annotation.isMemory = true
//                        annotation.image!.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: annotation.image!.size.height/2, right: 0))
//                        //                        annotation.title = memory.title
//                        //                        annotation.subtitle = memory.subtitle
//                        //                        let locAnnotation = LocationAnnotation(title: memory.title, subtitle: memory.subtitle, coordinate: )
//
//                        //                        let imageAnnotation = ImageAnnotation()
//                        current.append(annotation)
//                    }
//                }
//        }
//        self.currMemories = test_locations
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
