//
//  Location.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//
import Foundation
import CoreLocation

class Location: NSObject {
  
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  var locationManager = CLLocationManager()
  
  override init() {
    self.latitude = 0.00
    self.longitude = 0.00
    super.init()
  }
  
  func getCurrentLocation() {
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.distanceFilter = kCLDistanceFilterNone
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
    
    if let currLocation = locationManager.location {
      self.latitude = currLocation.coordinate.latitude
      self.longitude = currLocation.coordinate.longitude
    }
  }
}
