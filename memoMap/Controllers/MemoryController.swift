//
//  MemoryController.swift
//  memoMap
//
//  Created by Chloe Chan on 11/9/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MemoryController: ObservableObject {
  @Published var memories: [Memory] = MemoryRepository().memories
  @Published var memory: Memory = Memory(id: "", caption: "", front: "", back: "", location: "", username: "", timestamp: Date())
  
  init() {
    getMemoryData(id: "1")
  }
  
  func getMemoryData(id: String) {
    let docRef = Firestore.firestore().collection("memories").document(id)
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//        print("Document data: \(dataDescription)")
        
        let data = document.data()
        
        let caption = data!["caption"]! as? String ?? ""
        let front = data!["front"]! as? String ?? ""
        let back = data!["back"]! as? String ?? ""
        let location = data!["location"]! as? String ?? ""
        let username = data!["username"]! as? String ?? ""
        let timestamp = data!["timestamp"]! as? Date ?? Date()
        
        self.memory = Memory(id: id, caption: caption, front: front, back: back, location: location, username: username, timestamp: timestamp)
        
      } else {
        print("Document does not exist")
      }
    }
  }
}
