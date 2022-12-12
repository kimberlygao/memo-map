//
//  Location.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Place: Identifiable, Codable, Hashable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var address: String
  var city: String
  var latitude: Double
  var longitude: Double
  var name: String
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case address
    case city
    case latitude
    case longitude
    case name
  }
  
  init(address: String, city: String, latitude: Double, longitude: Double, name: String) {
    self.address = address
    self.city = city
    self.latitude = latitude
    self.longitude = longitude
    self.name = name
  }
}
