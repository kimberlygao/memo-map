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
  var memoryRepository : MemoryRepository = MemoryRepository()
  @Published var memories: [Memory] = []
  @Published var memory: Memory = Memory(id: "", caption: "", front: "", back: "", location: "", username: "", timestamp: Date())
  
  init() {
    getMemoryData(id: "1")
    self.memories = self.memoryRepository.memories
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
  
  func saveMemory(caption: String, front: Data, back: Data, location: String) {
    let id = UUID().uuidString
    print(type(of: front))
    let newfront = String(data: front, encoding: .utf8)!
    let newback = String(data: back, encoding: .utf8)!
    let time = Date() // format is 2022-11-10 04:30:39 +0000
    let username = "chloec" // later on make this username of curr user
    
    let mem = Memory(id: id, caption: caption, front: newfront, back: newback, location: location, username: username, timestamp: time)
//    self.uploadImagePic(field: "back", image: back)
//    self.uploadImagePic(field: "front", image: front)
    memoryRepository.add(mem)
  }
  
  func uploadImagePic(field: String, image: Data) {
      let filePath = "memories/1" // path where you wanted to store img in storage
      
      Firestore.firestore().collection("memories").document("1").setData([field : image as Data]){(error) in
        if let error = error {
          print(error.localizedDescription)
          return
        }else{
          //store downloadURL
          print("works")
        }
      }
  //    Firestore.firestore().collection("memories").document("1").updateData({"front": downloadURL})
    }
  
}
