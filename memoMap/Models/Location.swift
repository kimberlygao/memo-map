//
//  Location.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//
import Foundation
import CoreLocation
import MapKit

extension String {
  // recreating a function that String class no longer supports in Swift 2.3
  // but still exists in the NSString class. (This trick is useful in other
  // contexts as well when moving between NS classes and Swift counterparts.)
  
  /**
   Returns a new string made by appending to the receiver a given string.  In this case, a new string made by appending 'aPath' to the receiver, preceded if necessary by a path separator.
   
   - parameter aPath: The path component to append to the receiver. (String)
   
   - returns: A new string made by appending 'aPath' to the receiver, preceded if necessary by a path separator. (String)
   
  */
  func stringByAppendingPathComponent(aPath: String) -> String {
    let nsSt = self as NSString
    return nsSt.appendingPathComponent(aPath)
  }
}

class Location: NSObject, Identifiable {
    
  let id: UUID
//  var placemark: MKPlacemark
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  var locationManager = CLLocationManager()
//    var coordinate: CLLocationCoordinate2D
    var name: String?
    var address: String?
    var city: String?
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }

//    init(name: String) {
//        self.id = UUID()
//        self.name = name
//        self.address = ""
//        self.city = ""
//        self.latitude = 0.00
//        self.longitude = 0.00
//        super.init()
//    }
  override init() {
    self.id = UUID()
//    self.placemark = MKPlacemark(coordinate: CLLocationCoordinate2D())
    self.latitude = 0.00
    self.longitude = 0.00
      self.name = ""
      self.address = ""
      self.city = ""
    super.init()
  }
  
    func getCurrentLocation() {
      clearLocation()
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
      saveLocation()
    }
      
      func documentsDirectory() -> String {
         let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
         return paths[0]
       }

      func dataFilePath() -> String {
         return documentsDirectory().stringByAppendingPathComponent(aPath: "Coordinates.plist")
       }
      func saveLocation() {
         let data = NSMutableData()
         let archiver = NSKeyedArchiver(forWritingWith: data)
         archiver.encode(self.latitude, forKey: "latitude")
         archiver.encode(self.longitude, forKey: "longitude")
         archiver.finishEncoding()
         data.write(toFile: dataFilePath(), atomically: true)
       }

       func loadLocation() {
         let path = dataFilePath()
         if FileManager.default.fileExists(atPath: path) {
           if let data = NSData(contentsOfFile: path) {
             let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
             self.latitude = unarchiver.decodeDouble(forKey: "latitude")
             self.longitude = unarchiver.decodeDouble(forKey: "longitude")
             unarchiver.finishDecoding()
           } else {
             print("\nFILE NOT FOUND AT: \(path)")
           }
         }
       }

       func clearLocation () {
         self.latitude = 0.00
         self.longitude = 0.00
       }
    
//    class func from(json: JSON) -> Location? {
//        var name: String
//        if let unwrappedName = json["name"].string {
//            name = unwrappedName
//        } else {
//            name = ""
//        }
//        let lat = json["latitude"].doubleValue
//        let long = json["longitude"].doubleValue
//        let address = json["address"].string
//        let city = json["city"].string
//        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//
//        return Location(name: name, address: address, city: city, coordinate: coordinate)
//    }
}
