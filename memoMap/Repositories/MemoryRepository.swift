//
//  MemoryRepository.swift
//  memoMap
//
//  Created by Chloe Chan on 11/9/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class MemoryRepository: ObservableObject {
  private let path: String = "memories"
  private let store = Firestore.firestore()

  @Published var memories: [Memory] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get()
  }

  func get() {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting memory: \(error.localizedDescription)")
          return
        }

        self.memories = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Memory.self)
        } ?? []
      }
  }

  // MARK: CRUD methods
  func add(_ memory: Memory) {
    do {
      let newMemory = memory
      _ = try store.collection(path).addDocument(from: newMemory)
    } catch {
      fatalError("Unable to add memory: \(error.localizedDescription).")
    }
  }

  func update(_ memory: Memory) {
    guard let memoryID = memory.id else { return }
    
    do {
      try store.collection(path).document(memoryID).setData(from: memory)
    } catch {
      fatalError("Unable to update memory: \(error.localizedDescription).")
    }
  }

  func remove(_ memory: Memory) {
    guard let memoryID = memory.id else { return }
    
    store.collection(path).document(memoryID).delete { error in
      if let error = error {
        print("Unable to remove memory: \(error.localizedDescription)")
      }
    }
  }
  

}

