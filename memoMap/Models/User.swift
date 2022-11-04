//
//  User.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
  
  // MARK: Fields
  @DocumentID var username: String?
  var email: String
  var friends: [String]
  var memories: [Memory]
  var name: String
  var password: String
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case username
    case email
    case friends
    case memories
    case name
    case password
  }
}
