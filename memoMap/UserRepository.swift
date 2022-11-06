//
//  UserRepository.swift
//  memoMap
//
//  Created by Chloe Chan on 11/5/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepository: ObservableObject {
  private let path: String = "users"
  private let store = Firestore.firestore()

  @Published var users: [User] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    print("first line")
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting users: \(error.localizedDescription)")
          return
        }
//        print("test")
//        if let q = querySnapshot {
//          for doc in q.documents {
//            print("inside q")
//            try? print(doc.data)
//          }
//          
//        } else {print("no query snapshot")}
        
        
        
        self.users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
        print("hello")
        print("---------------------------")
        print(self.users)
          for user in self.users {
//            for memory in user.memories {
//              print("memory caption")
//              print(memory.caption)
//            }
            print("friends")
            print(user.friends)
            print("\n")
          }
      }
    print("bye")
  }

  // MARK: CRUD methods
  func add(_ user: User) {
    do {
      let newUser = user
      _ = try store.collection(path).addDocument(from: newUser)
    } catch {
      fatalError("Unable to add user: \(error.localizedDescription).")
    }
  }

  func update(_ user: User) {
    guard let username = user.id else { return }
    
    do {
      try store.collection(path).document(username).setData(from: user)
    } catch {
      fatalError("Unable to update user: \(error.localizedDescription).")
    }
  }

  func remove(_ user: User) {
    guard let username = user.id else { return }
    
    store.collection(path).document(username).delete { error in
      if let error = error {
        print("Unable to remove user: \(error.localizedDescription)")
      }
    }
  }
  

}
