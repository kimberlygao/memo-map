//
//  FriendRequestController.swift
//  memoMap
//
//  Created by Chloe Chan on 11/13/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FriendRequestController: ObservableObject {
  @Published var friendRequestRepository: FriendRequestRepository = FriendRequestRepository()
  @Published var requests: [FriendRequest] = []
  
  init() {
    self.friendRequestRepository.get({(requests) -> Void in
      self.requests = requests
    })
  }
}

