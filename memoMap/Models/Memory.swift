//
//  Memory.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Memory: Identifiable, Codable, Hashable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var caption: String
  var front: String
  var back: String
  var location: String
  var username: String
  var timestamp: Date
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case caption
    case front
    case back
    case location
    case username
    case timestamp
  }
  
  init(id: String, caption: String, front: String, back: String, location: String, username: String, timestamp: Date) {
    self.id = id
    self.caption = caption
    self.front = front
    self.back = back
    self.location = location
    self.username = username
    self.timestamp = timestamp
  }
}
