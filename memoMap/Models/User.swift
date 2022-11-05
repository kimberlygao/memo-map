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
  @DocumentID var id: String?
  var email: String
  var friends: [String]
  var memories: [Memory]
//  var name: String
//  var password: String
//  var requests: [FriendRequest]?
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case email
    case friends
    case memories
//    case name
//    case password
//    case requests = "friend_requests"
  }
}
