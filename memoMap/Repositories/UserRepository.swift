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
    self.get({ (users) -> Void in
      self.users = users
    })
  }
  
  func get(_ completionHandler: @escaping (_ users: [User]) -> Void) {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting place: \(error.localizedDescription)")
          return
        }

        let users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
        completionHandler(users)
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
