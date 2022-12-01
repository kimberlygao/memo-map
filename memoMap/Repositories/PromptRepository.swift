//
//  PromptRepository.swift
//  memoMap
//
//  Created by Chloe Chan on 12/1/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class PromptRepository: ObservableObject {
  private let path: String = "prompts"
  private let store = Firestore.firestore()

  @Published var prompts: [Prompt] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get({ (prompts) -> Void in
      self.prompts = prompts
    })
  }

  func get(_ completionHandler: @escaping (_ prompts: [Prompt]) -> Void) {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting prompts: \(error.localizedDescription)")
          return
        }

        let prompts = querySnapshot?.documents.compactMap { document in
          try? document.data(as: Prompt.self)
        } ?? []
        completionHandler(prompts)
      }
  }

  // MARK: CRUD methods
  func add(_ prompt: Prompt) {
    do {
      let newPrompt = prompt
      _ = try store.collection(path).addDocument(from: newPrompt)
    } catch {
      fatalError("Unable to add prompt: \(error.localizedDescription).")
    }
  }

  func update(_ prompt: Prompt) {
    guard let promptID = prompt.id else { return }
    
    do {
      try store.collection(path).document(promptID).setData(from: prompt)
    } catch {
      fatalError("Unable to update prompt: \(error.localizedDescription).")
    }
  }

  func remove(_ prompt: Prompt) {
    guard let promptID = prompt.id else { return }
    
    store.collection(path).document(promptID).delete { error in
      if let error = error {
        print("Unable to remove prompt: \(error.localizedDescription)")
      }
    }
  }
  

}

