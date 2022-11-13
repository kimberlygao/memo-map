//
//  MapViewController.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import UIKit
import MapKit
import Foundation
//import FloatingPanel


extension MapViewController: MKMapViewDelegate {
  
}

class MapViewController: UIViewController, ObservableObject {
  let current : Location = Location()
  let locations: [Location] = []
  var mapView : MKMapView = MKMapView(frame: .zero)
  var locationManager: CLLocationManager!
  var nearbyPlaces: [MKMapItem] = []
  var searchRegion: MKCoordinateRegion = MKCoordinateRegion()
  //    var pointOfInterestCategory = MKPointOfInterestCategory? { get set }
  
  override func viewDidLoad() {
    print("HERE")
    super.viewDidLoad()
    //        addMapAnnotations()
    
    //        self.initControls()
    //        self.doLayout()
    //        self.loadAnnotations()
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
  
  //    func initControls() {
  //            self.mapView = MKMapView()
  //
  //            self.mapView.isRotateEnabled = true
  //            self.mapView.showsUserLocation = true
  //            self.mapView.delegate = self
  //
  //            let center = CLLocationCoordinate2DMake(43.761539, -79.411079)
  //            let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
  //            self.mapView.setRegion(region, animated: true)
  //        }
  //
  //        func doLayout() {
  //            self.view.addSubview(self.mapView)
  //            self.mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
  //            self.mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
  //            self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
  //            self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
  //            self.mapView.translatesAutoresizingMaskIntoConstraints = false
  //        }
  //
  //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
  //        if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
  //            return nil  //Default is to let the system handle it.
  //        }
  //
  //        if !annotation.isKind(of: LocationAnnotation.self) {  //Handle non-ImageAnnotations..
  //            var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "DefaultPinView")
  //            if pinAnnotationView == nil {
  //                pinAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DefaultPinView")
  //            }
  //            return pinAnnotationView
  //        }
  //
  //        //Handle ImageAnnotations..
  //        var view: LocationAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? ImageAnnotationView
  //        if view == nil {
  //            view = LocationAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
  //        }
  //
  //        let annotation = annotation as! LocationAnnotation
  //        view?.image = annotation.image
  //        view?.annotation = annotation
  //
  //        return view
  //    }
  //
  //        func loadAnnotations() {
  //            let request = NSMutableURLRequest(url: URL(string: "https://i.imgur.com/zIoAyCx.png")!)
  //            request.httpMethod = "GET"
  //
  //            let session = URLSession(configuration: URLSessionConfiguration.default)
  //            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
  //                if error == nil {
  //
  //                    let annotation = LocationAnnotation()
  //                    annotation.coordinate = CLLocationCoordinate2DMake(43.761539, -79.411079)
  //                    annotation.image = UIImage(data: data!, scale: UIScreen.main.scale)
  //                    annotation.title = "Toronto"
  //                    annotation.subtitle = "Yonge & Bloor"
  //
  //
  //                    DispatchQueue.main.async {
  //                        self.mapView.addAnnotation(annotation)
  //                    }
  //                }
  //            }
  //
  //            dataTask.resume()
  //        }
  
  func addMapAnnotations() {
    print("HERE")
    let test_locations = [
      ["name": "Delainie Coffee", "latitude": 40.4288961, "longitude": -79.9807498,],
      ["name": "Bird on the Run South Side", "latitude": 40.4290, "longitude": -79.9809],
      ["name": "Insomnia Cookies", "latitude": 40.428620, "longitude": -79.980860],
      ["name": "Bruegger's Bagels", "latitude": 40.428951, "longitude": -79.980377],
    ]
    print("HERE")
    for location in test_locations {
      print("location: ", location)
      let annotation = MKPointAnnotation()
      annotation.title = location["name"] as? String
      
      let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
      annotation.coordinate = loc
      //            self.annotations.append(annotation)
      self.mapView.addAnnotation(annotation)
      print("added")
    }
  }
  
  func getNearbyLocations(using searchRequest: MKLocalSearch.Request) -> [String] {
    print("get nearby location")
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
      print("nearby places")
      print(self.nearbyPlaces)
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
  
  func performSearch(search: String) {
    print("searching")
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
