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
  @Published var memoryController: MemoryController = MemoryController()
  @Published var users: [User] = []
  @Published var currentUser: User = User(email: "", friends: [], memories: [], name: "", password: "", requests: [], pfp: "default.jpeg")
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
    return self.users.filter { user.friends.contains($0.id!) }
  }
  
  func getFriendStatus(currUser: User, otherUser: User) -> String {
        if currUser.id == otherUser.id {
            return "yourself"
          }
        if self.getFriends(user: currUser).contains(otherUser) {
            return "friends"
          }
        if self.getSentRequests(user: currUser).contains(otherUser) {
            return "requestSent"
          }
        if self.getReceivedRequests(user: currUser).contains(otherUser) {
            return "requestReceived"
          }
        return "noStatus"
        
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
  
  func sendFriendRequest(currUser: User, receiver: User) {
        let request = FriendRequest(id: UUID().uuidString, receiver: receiver.id!, requester: currUser.id!)
        friendRequestRepository.add(request)
        
        var curr = currUser
        curr.requests.append(request.id!)
        userRepository.update(curr)
        var rec = receiver
        rec.requests.append(request.id!)
        userRepository.update(rec)
      }
    
    func processFriendRequest(currUser: User, requester: User, clicked: String) {
        let request = self.requests.filter { $0.requester == requester.id && $0.receiver == currUser.id }
        
        if clicked == "accept" {
            var curr = currUser
            curr.friends.append(requester.id!)
            userRepository.update(curr)
            var reqer = requester
            reqer.friends.append(currUser.id!)
            userRepository.update(reqer)
          }
        
        for req in request {
            friendRequestRepository.remove(req)
          }
      }
  
  func getStats(user: User) -> [String] {
    let userMems = memoryController.getMemoriesForUser(user: user)
    let userPlaces = userMems.map { $0.location }
    
    let numPlaces = Set(userPlaces).count
    let numMemories = user.memories.count
    let numFriends = user.friends.count
    
    let stats = [numPlaces, numMemories, numFriends].map { String($0) }
    
    return stats
  }
}
