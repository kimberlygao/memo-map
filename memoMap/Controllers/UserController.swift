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
  @Published var requests = FriendRequestController().requests
  @Published var userRepository: UserRepository = UserRepository()
  @Published var users: [User] = []
  @Published var currentUser: User = User(email: "", friends: [], memories: [], name: "", password: "", requests: nil)
  
  init() {
    self.userRepository.get({(users) -> Void in
      for user in users {
        if user.id == "kwgao" {
          self.currentUser = user
        }
      }
      self.users = users
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
  
  func getRequests(user: User) -> [User] {
    var friends: [User] = []
    for person in self.users {
      if user.friends.contains(person.id!) {
        friends.append(person)
      }
    }
    return friends
  }
}
