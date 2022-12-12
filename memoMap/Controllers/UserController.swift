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
  @Published var currentUser: User = User(email: "", friends: [], memories: [], name: "", password: "", requests: [], pfp: "default.jpeg")
  @Published var requests: [FriendRequest] = []
  @Published var pfpURLs: [String] = []
  
  init() {
    // get users
    self.userRepository.get({(users) -> Void in
      for user in users {
        if user.id == "fionac" {
          self.currentUser = user
        }
      }
      self.users = users
      self.pfpURLs = users.map { $0.pfp }
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
    let id = UUID().uuidString
    let request = FriendRequest(receiver: receiver.id!, requester: currUser.id!, uuid: id)
    friendRequestRepository.add(request)
    
    var curr = currUser
    curr.requests.append(id)
    userRepository.update(curr)
    var rec = receiver
    rec.requests.append(id)
    userRepository.update(rec)
  }
  
  func processFriendRequest(currUser: User, requester: User, clicked: String) {
    let request = self.requests.first { $0.requester == requester.id && $0.receiver == currUser.id }
    
    var curr = currUser
    var reqer = requester
    
    if clicked == "accept" {
      curr.friends.append(requester.id!)
      reqer.friends.append(currUser.id!)
    }
    
    let i = curr.requests.firstIndex(where: { $0 == request!.uuid })
    let j = reqer.requests.firstIndex(where: { $0 == request!.uuid })
    if let i = i {
      curr.requests.remove(at: i)
    }
    if let j = j {
      reqer.requests.remove(at: j)
    }
    
    userRepository.update(curr)
    userRepository.update(reqer)
    friendRequestRepository.remove(request!)
  }
  
  func getStats(user: User, memoryController: MemoryController) -> [String] {
    let userMems = memoryController.getMemoriesForUser(user: user)
    //    assert(userMems.count == user.memories.count)
    let userPlaces = userMems.map { $0.location }
    
    let numPlaces = Set(userPlaces).count
    let numMemories = user.memories.count
    let numFriends = user.friends.count
    
    let stats = [numPlaces, numMemories, numFriends].map { String($0) }
    
    return stats
  }
  
  func getUserFromMemory(mem: Memory) -> User? {
    let users = self.users.filter { $0.id! == mem.username }
    return users.first ?? nil
  }
}
