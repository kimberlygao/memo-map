//
//  PlaceRepository.swift
//  memoMap
//
//  Created by Chloe Chan on 11/5/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class PlaceRepository: ObservableObject {
  private let path: String = "places"
  private let store = Firestore.firestore()

  @Published var places: [Place] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting place: \(error.localizedDescription)")
          return
        }

        self.places = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Place.self)
        } ?? []
      }
  }

  // MARK: CRUD methods
  func add(_ place: Place) {
    do {
      let newPlace = place
      _ = try store.collection(path).addDocument(from: newPlace)
    } catch {
      fatalError("Unable to add place: \(error.localizedDescription).")
    }
  }

  func update(_ place: Place) {
    guard let placeID = place.id else { return }
    
    do {
      try store.collection(path).document(placeID).setData(from: place)
    } catch {
      fatalError("Unable to update place: \(error.localizedDescription).")
    }
  }

  func remove(_ place: Place) {
    guard let placeID = place.id else { return }
    
    store.collection(path).document(placeID).delete { error in
      if let error = error {
        print("Unable to remove place: \(error.localizedDescription)")
      }
    }
  }
  

}
