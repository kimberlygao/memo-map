//
//  LocationRepository.swift
//  memoMap
//
//  Created by Chloe Chan on 11/5/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class LocationRepository: ObservableObject {
  private let path: String = "locations"
  private let store = Firestore.firestore()

  @Published var locations: [Location] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    print("init")
    self.get()
  }

  func get() {
    print("first line")
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting location: \(error.localizedDescription)")
          return
        }

        self.locations = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Location.self)
        } ?? []
        print("hello")
        print("---------------------------")
          print("\n")
          for location in self.locations {
            print("address:")
            print(location.address)
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
