//
//  Memory.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Memory: Identifiable, Codable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var caption: String
  var front: String
  var back: String
//  var location: [Location]
  var username: String
  var timestamp: Date
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case caption
    case front
    case back
//    case location
    case username
    case timestamp
  }
}
