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
import MapKit

class MemoryController: ObservableObject {
  let storage = Storage.storage()
  var memoryRepository : MemoryRepository = MemoryRepository()
  @Published var placeController : PlaceController = PlaceController()
  @Published var memories: [Memory] = []
  @Published var images: [String : UIImage] = [:]
  
  init() {
    // get all memories
    self.memories = memoryRepository.memories
//    self.memoryRepository.get({(memories) -> Void in
//      self.memories = memories
//    })
    
    self.images = memoryRepository.images
  }
  
  func getMemoriesForUser(user: User) -> [Memory] {
    return self.memories.filter { $0.username == user.id }
  }
  
  
  func getMemoryPinsForUser(user: User) -> [ImageAnnotation] {
    let memories: [Memory] = getMemoriesForUser(user: user)
    var pins: [ImageAnnotation] = []
    
    for mem in memories {
      let place = placeController.getPlaceFromID(id: mem.location)
      let coords = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
      let locAnnotation = LocationAnnotation(title: place.name, subtitle: "none", coordinate: coords)
      let imgUrl = mem.back
      let img = self.images[imgUrl] ?? UIImage()
      
      let pin = ImageAnnotation(id: UUID().uuidString, locAnnotation: locAnnotation, isMemory: true, url: imgUrl, image: img)
      pins.append(pin)
//      let pin = ImageAnnotation(id: mem.id!, locAnnotation: locAnnotation, isMemory: true, url: mem.back, image: img)
      
    }
    return pins
  }
  
  func getFriendsMemoryPins(users: [User]) -> [ImageAnnotation] {
      let allPins = users.map { self.getMemoryPinsForUser(user: $0) }
      return allPins.flatMap { $0 }
    }

    func getFriendsMemories(users: [User]) -> [Memory] {
      let allMems = users.map { self.getMemoriesForUser(user: $0) }
      return allMems.flatMap { $0 }
    }

    func getFriendsMemoriesForLocation(users: [User], loc: Place) -> [Memory] {
      let allMems = self.getFriendsMemories(users: users)
      return allMems.filter { $0.location == loc.id }
    }
  
  func saveMemory(caption: String, front: UIImage, back: UIImage, location: String) {
    let id = UUID().uuidString
    let newfront =  uploadPhoto(front)
    let newback =  uploadPhoto(back)
    let time = Date() // format is 2022-11-10 04:30:39 +0000
    let username = "kwgao" // later on make this username of curr user
    
    print("STORING MEMORY")
    
    let mem = Memory(id: id, caption: caption, front: newfront, back: newback, location: location, username: username, timestamp: time)
    memoryRepository.add(mem)
  }
  
  func uploadPhoto(_ photo: UIImage) -> String {
    print(photo)
    let url = "\(UUID().uuidString).jpg"
    let storageRef = Storage.storage().reference().child(url)
    let data = photo.jpegData(compressionQuality: 0.2)
    let metadata = StorageMetadata()
    metadata.contentType = "image/jpg"
    if let data = data {
      storageRef.putData(data, metadata: metadata) { (metadata, error) in
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
