//
//  Location.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Location: Identifiable, Codable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var address: String
  var city: String
  var latitude: Float
  var longitude: Float
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
}
