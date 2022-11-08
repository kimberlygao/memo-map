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
    self.get()
  }

  func get() {
    let docRef = store.collection("users").document("chloec")
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
            
            let data = document.data()
            let name = data!["name"]! as? String ?? ""
            print("nameeee: \(name)")
        } else {
            print("Document does not exist")
        }
    }
    
//    // new stuff
//    let docref = store.collection(path).document("chloec")
//    print("docref: \(docref)")
//    store.collection(path).document().setData([
//      "id": docref,
//      "email": docref.email
//    ]) { err in
//      if let err = err {
//        print("Error writing document: \(err)")
//      } else {
//        print("Document successfully written!")
//      }
//    }
    
    store.collection(path)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error getting users: \(error.localizedDescription)")
          return
        }
//        print("test")
//        if let q = querySnapshot {
//          for doc in q.documents {
//            print("inside q")
//            try? print(doc.data)
//          }
//          
//        } else {print("no query snapshot")}
        
        self.users = querySnapshot?.documents.compactMap { document in
          try? document.data(as: User.self)
        } ?? []
        print("---------------------------")
        print("hello users")
        print(self.users)
          for user in self.users {
            print("friends: \(user.friends)")
        
            print("\n")
            for friend in user.friends {
              print("friend: \(friend)")
              print("\n")
            }
            
          }
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
