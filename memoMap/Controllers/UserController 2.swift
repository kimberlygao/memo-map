//
//  UserController.swift
//  memoMap
//
//  Created by Chloe Chan on 11/9/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserController: ObservableObject {
  @Published var users: [User] = UserRepository().users
  @Published var user: User = User(email: "", friends: [], memories: [], name: "", password: "", requests: nil)
  
  init() {
    getUserData(username: "chloec")
  }
  
  func getUserData(username: String) {
    let docRef = Firestore.firestore().collection("users").document(username)
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//        print("Document data: \(dataDescription)")
        
        let data = document.data()
        
        let name = data!["name"]! as? String ?? ""
        let friends = data!["friends"]! as? [String] ?? []
        let email = data!["email"]! as? String ?? ""
        let memories = data!["memories"]! as? [String] ?? []
        let password = data!["password"]! as? String ?? ""
        let requests = data!["requests"]! as? [String] ?? []
        self.user = User(email: email, friends: friends, memories: memories, name: name, password: password, requests: requests)
        
      } else {
        print("Document does not exist")
      }
    }
  }
}
