//
//  UserController.swift
//  memoMap
//
//  Created by Chloe Chan on 11/9/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserController: ObservableObject {
  @Published var friendRequestRepository: FriendRequestRepository = FriendRequestRepository()
  @Published var userRepository: UserRepository = UserRepository()
  @Published var users: [User] = []
  @Published var currentUser: User = User(email: "", friends: [], memories: [], name: "", password: "", requests: nil)
  @Published var requests: [FriendRequest] = []
  
  init() {
    // get users
    self.userRepository.get({(users) -> Void in
      for user in users {
        if user.id == "kwgao" {
          self.currentUser = user
        }
      }
      self.users = users
    })
    
    // get friend requests
    self.friendRequestRepository.get({(requests) -> Void in
      self.requests = requests
    })
  }
  
  func getFriends(user: User) -> [User] {
    var friends: [User] = []
    for person in self.users {
      if user.friends.contains(person.id!) {
        friends.append(person)
      }
    }
    return friends
  }
  
  func getSentRequests(user: User) -> [User] {
    var temp: [String] = []
    var sent: [User] = []
    
    for req in self.requests {
      if req.requester == user.id {
        temp.append(req.receiver)
      }
    }
    for person in self.users {
      if temp.contains(person.id!) {
        sent.append(person)
      }
    }
    
    return sent
  }
  
  func getReceivedRequests(user: User) -> [User] {
    var temp: [String] = []
    var received: [User] = []
    
    for req in self.requests {
      if req.receiver == user.id {
        temp.append(req.requester)
      }
    }
    for person in self.users {
      if temp.contains(person.id!) {
        received.append(person)
      }
    }
    
    return received
  }
}
