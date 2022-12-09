//
//  FriendRequestRepository.swift
//  memoMap
//
//  Created by Chloe Chan on 11/13/22.
//
import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class FriendRequestRepository: ObservableObject {
  private let path: String = "friend-requests"
  private let store = Firestore.firestore()

  @Published var requests: [FriendRequest] = []
  private var cancellables: Set<AnyCancellable> = []

  init() {
    self.get({ (requests) -> Void in
      self.requests = requests
    })
  }

  func get(_ completionHandler: @escaping (_ requests: [FriendRequest]) -> Void) {
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting friend requests: \(error.localizedDescription)")
          return
        }

        let requests = querySnapshot?.documents.compactMap { document in
          try? document.data(as: FriendRequest.self)
        } ?? []
        completionHandler(requests)
      }
  }

  // MARK: CRUD methods
  func add(_ request: FriendRequest) {
    do {
      let newRequest = request
      _ = try store.collection(path).addDocument(from: newRequest)
    } catch {
      fatalError("Unable to add friend request: \(error.localizedDescription).")
    }
  }

  func update(_ request: FriendRequest) {
    guard let requestID = request.id else { return }
    
    do {
      try store.collection(path).document(requestID).setData(from: request)
    } catch {
      fatalError("Unable to update request: \(error.localizedDescription).")
    }
  }

  func remove(_ request: FriendRequest) {
    guard let requestID = request.id else { return }
    
    store.collection(path).document(requestID).delete { error in
      if let error = error {
        print("Unable to remove request: \(error.localizedDescription)")
      }
    }
  }
  

}
