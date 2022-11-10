//
//  LocationManager.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import Foundation
import CoreLocation


//import Foundation
//import MapKit
//
//class LocationManager: NSObject, ObservableObject {
//    private let locationManager = CLLocationManager()
//
//    var location: CLLocation? = nil
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.distanceFilter = kCLDistanceFilterNone
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print(status)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocation locations: [CLLocation]) {
//        guard let location = locations.last else {
//            return
//        }
//        self.location = location
//    }
//}
//
//class LocationManager: NSObject {
//    static let shared = LocationManager()
//    let manager = CLLocationManager()
//
//    public func findLocations(with query: String, completion: @escaping (([Location]) -> Void)) {
//        let geoCoder = CLGeoCoder()
//        guard let places = places, error == nil else {
//            completion([])
//            return
//        }
//
//        let models : [Location] = places.compactMap({ place in
//            var name = ""
//            if let locationName = place.name {
//                name += locationName
//            }
//            let result = Location(name: name, latitude: 0.00, longitude: 0.00)
//            return result
//        })
//    }
//
//}
