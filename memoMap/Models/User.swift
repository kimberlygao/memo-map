//
//  User.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var ref: DocumentReference?
  var email: String
  var friends: [User]
//  var memories: [Memory]
  var name: String
  var password: String
//  var requests: [FriendRequest]?
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case email
    case friends
//    case memories
    case name
    case password
//    case requests = "friend_requests"
  }
  
  init(email: String, friends: [User], name: String, password: String) {
    self.ref = nil
    self.email = email
    self.friends = friends
    self.name = name
    self.password = password
    
  }
  
}
