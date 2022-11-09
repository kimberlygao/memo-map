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
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting location: \(error.localizedDescription)")
          return
        }

        self.locations = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Location.self)
        } ?? []
      }
  }

  // MARK: CRUD methods
  func add(_ location: Location) {
    do {
      let newLocation = location
      _ = try store.collection(path).addDocument(from: newLocation)
    } catch {
      fatalError("Unable to add location: \(error.localizedDescription).")
    }
  }

  func update(_ location: Location) {
    guard let locationID = location.id else { return }
    
    do {
      try store.collection(path).document(locationID).setData(from: location)
    } catch {
      fatalError("Unable to update location: \(error.localizedDescription).")
    }
  }

  func remove(_ location: Location) {
    guard let locationID = location.id else { return }
    
    store.collection(path).document(locationID).delete { error in
      if let error = error {
        print("Unable to remove location: \(error.localizedDescription)")
      }
    }
  }
  

}
