//
//  FriendRequest.swift
//  memoMap
//
//  Created by Chloe Chan on 11/4/22.
//

import Foundation
import FirebaseFirestoreSwift

struct FriendRequest: Identifiable, Codable {
  
  // MARK: Fields
  @DocumentID var id: String?
  var receiver: User
  var requester: User
  
  // MARK: Codable
  enum CodingKeys: String, CodingKey {
    case id
    case receiver
    case requester
  }
}
