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
import UIKit
import FirebaseStorage

class MemoryRepository: ObservableObject {
  private let path: String = "memories"
  private let store = Firestore.firestore()

  @Published var memories: [Memory] = []
  @Published var images: [String : UIImage] = [:]
  private var cancellables: Set<AnyCancellable> = []

  init() {
    // get all memories
    self.get({ (memories) -> Void in
      self.memories = memories
    })
    
    // get all photos
    self.getPhotos()
  }
  
  func get(_ completionHandler: @escaping (_ memories: [Memory]) -> Void) {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting memories: \(error.localizedDescription)")
          return
        }

        let memories = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Memory.self)
        } ?? []
        completionHandler(memories)
      }
  }
  
  func getPhoto(_ completionHandler: @escaping (_ image: UIImage?) -> Void, _ url: String) -> Void {
    let storage = Storage.storage()
    let ref = storage.reference().child(url)
    ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        print("Error getting photo \(url): \(error)")
      } else {
        let image = UIImage(data: data!)
        completionHandler(image)
      }
    }
  }
  
  func getPhotos() -> Void {
    let frontUrls: [String] = self.memories.map { $0.front}
    let backUrls: [String] = self.memories.map { $0.back}
    let urls = frontUrls + backUrls
    
    for url in urls {
      self.getPhoto({ (image) -> Void in (self.images[url] = image)}, url)
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
