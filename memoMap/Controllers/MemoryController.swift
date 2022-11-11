//
//  MemoryController.swift
//  memoMap
//
//  Created by Chloe Chan on 11/9/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit
import FirebaseStorage

class MemoryController: ObservableObject {
  let storage = Storage.storage()
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
  
   func saveMemory(caption: String, front: UIImage, back: UIImage, location: String) {
    let id = UUID().uuidString
    print(type(of: front))
    
    let newfront =  uploadPhoto(front)
    let newback =  uploadPhoto(back)
    let time = Date() // format is 2022-11-10 04:30:39 +0000
    let username = "chloec" // later on make this username of curr user
     
    print("STORING MEMORY")
    
    let mem = Memory(id: id, caption: caption, front: newfront, back: newback, location: location, username: username, timestamp: time)
//    self.uploadImagePic(field: "back", image: back)
//    self.uploadImagePic(field: "front", image: front)
    memoryRepository.add(mem)
  }
  
  func uploadPhoto(_ photo: UIImage) -> String {
    print(photo)
      let url = "\(UUID().uuidString).jpg"
      print("ONE")
      let storageRef = Storage.storage().reference().child(url)
    print("TWO")
      let data = photo.jpegData(compressionQuality: 0.2)
    print("THREE")
    print(data)
      let metadata = StorageMetadata()
      metadata.contentType = "image/jpg"
      if let data = data {
        print("PUTTING DATA")
        storageRef.putData(data, metadata: metadata) { (metadata, error) in
          print("ERROR CHECKING")
          if let error = error {
            print("Error while uploading file: ", error)
          }
          if let metadata = metadata {
            print("Metadata: ", metadata)
          }
        }
      }
    
      return url
    }
  
}
