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
    print("lksjdfslk", user.name)
    let friends: [User] = self.users.filter { user.friends.contains($0.id!) }
    print("slkdjfl:", friends)
    return friends
  }
  
//  func getFriendsWrapper(user: User) -> [User] {
//    print("user name wraopper", user.name)
//    var res: [User] = []
//    self.getFriends(for: user) {(friends) -> Void in
//      print("inside: \(friends)")
//      res = friends
//    }
//    print("outside: \(res)")
//    return res
//  }

  
//  func getFriends(for user: User, completion: @escaping ([User]) -> Void) {
//    print("user friends:", user.name)
//
//    DispatchQueue.global().async {
////      let friends: [User] = self.users.filter { (person) -> Bool in
////        return user.friends.contains(person.id!)
////      }
//
//      let friends: [User] = self.users.filter { user.friends.contains($0.id!) }
//      print("getFriends:", friends)
//      completion(friends)
//    }
//  }
  
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
    print("skdfjlsdj", received)
    return received
  }
}
