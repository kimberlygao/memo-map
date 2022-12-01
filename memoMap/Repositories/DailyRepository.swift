//
//  DailyRepository.swift
//  memoMap
//
//  Created by Chloe Chan on 12/1/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class DailyPromptRepository: ObservableObject {
  private let path: String = "daily-prompt"
  private let store = Firestore.firestore()

  @Published var dailys: [DailyPrompt] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get({ (dailys) -> Void in
      self.dailys = dailys
    })
  }

  func get(_ completionHandler: @escaping (_ dailys: [DailyPrompt]) -> Void) {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting daily prompt answers: \(error.localizedDescription)")
          return
        }

        let dailys = querySnapshot?.documents.compactMap { document in
          try? document.data(as: DailyPrompt.self)
        } ?? []
        completionHandler(dailys)
      }
  }

  // MARK: CRUD methods
  func add(_ daily: DailyPrompt) {
    do {
      let newDaily = daily
      _ = try store.collection(path).addDocument(from: newDaily)
    } catch {
      fatalError("Unable to add daily prompt answer: \(error.localizedDescription).")
    }
  }

  func update(_ daily: DailyPrompt) {
    guard let dailyID = daily.id else { return }
    
    do {
      try store.collection(path).document(dailyID).setData(from: daily)
    } catch {
      fatalError("Unable to update daily prompt answer: \(error.localizedDescription).")
    }
  }

  func remove(_ daily: DailyPrompt) {
    guard let dailyID = daily.id else { return }
    
    store.collection(path).document(dailyID).delete { error in
      if let error = error {
        print("Unable to remove daily prompt answer: \(error.localizedDescription)")
      }
    }
  }
  

}


