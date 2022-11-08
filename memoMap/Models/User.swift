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
  var friends: [String]
  var memories: [String]
  var name: String
  var password: String
  var requests: [String]?
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case email
    case friends
    case memories
    case name
    case password
    case requests = "friend_requests"
  }
  
  init(email: String, friends: [String], memories: [String], name: String, password: String, requests: [String]) {
    self.email = email
    self.friends = friends
    self.memories = memories
    self.name = name
    self.password = password
    self.requests = requests
      
  }
  
}


