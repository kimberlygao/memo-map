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

  @Published var user: User
  
  init() {
    self.get()
    self.getUserData(username: "chloec")
    
//    print(self.getUserData(username: "chloec"))
  }
  
  func getUserData(username: String) {
    let docRef = Firestore.firestore().collection("users").document(username)
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        print("Document data: \(dataDescription)")
        
        let data = document.data()
        
        let name = data!["name"]! as? String ?? ""
        let friends = data!["friends"]! as? [String] ?? []
        let email = data!["email"]! as? String ?? ""
        let memories = data!["memories"]! as? [String] ?? []
        let password = data!["password"]! as? String ?? ""
        let requests = data!["requests"]! as? [String] ?? []
        self.user = User(email: email, friends: friends, memories: memories, name: name, password: password, requests: requests)
        
      } else {
        print("Document does not exist")
      }
    }
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting users: \(error.localizedDescription)")
          return
        }
        
        self.users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
      }
  
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
