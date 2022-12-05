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
import OrderedCollections

class MemoryController: ObservableObject {
  let storage = Storage.storage()
  var memoryRepository : MemoryRepository = MemoryRepository()
  @Published var placeController : PlaceController = PlaceController()
  @Published var userController : UserController = UserController()
  @Published var memories: [Memory] = []
  @Published var images: [(String, UIImage)] = []
  
  init() {
    self.memoryRepository.get({ [self](memories) -> Void in
      // get all memories
      self.memories = memories
      
      // get all images
      let urls = memories.map { $0.front } + memories.map { $0.back } + userController.pfpURLs
      for url in urls {
        let _ = self.memoryRepository.getPhoto({ (image) -> Void in self.images.append((url, image!)) }, url)
      }
    })
  }
  
    func getCurrentUser() -> User {
        return userController.currentUser
    }
    
  func getPfpUser(user: User) -> UIImage {
    return getImageFromURL(url: user.pfp)
  }
  
  func getPfpFromMemory(mem: Memory) -> UIImage {
    let user = userController.getUserFromMemory(mem: mem)
    if let user = user {
      return getImageFromURL(url: user.pfp)
    }
    return UIImage()
  }
  
  func getMemoriesForUser(user: User) -> [Memory] {
    let mems = self.memories.filter { String($0.username) == String(user.id!) }
    return mems.sorted { $0.timestamp >= $1.timestamp }
  }
  
  func getMemoryPinsForUser(user: User) -> [ImageAnnotation] {
    let memories: [Memory] = self.getMemoriesForUser(user: user)
    var pins: [ImageAnnotation] = []
    
    for mem in memories {
      let place = placeController.getPlaceFromID(id: mem.location)
      let coords = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
      let locAnnotation = LocationAnnotation(title: place.name, subtitle: "none", coordinate: coords)
      let imgUrl = mem.back
      let img = self.getImageFromURL(url: imgUrl)
      print("getMemoryPinsForUser curr image:", img)
      let pin = ImageAnnotation(id: UUID().uuidString, locAnnotation: locAnnotation, isMemory: true, url: imgUrl, image: img)
      
//      let pin = ImageAnnotation(id: mem.id!, locAnnotation: locAnnotation, isMemory: true, url: mem.back, image: img)
      pins.append(pin)
    }
    return pins
  }
  
  func getFriendsMemories(user: User) -> [Memory] {
    var users: [User] = userController.getFriends(user: user)
    users.append(userController.currentUser) // delete this if u dont want to append urself, idk what is better LOL
    let allMems: [[Memory]] = users.map { self.getMemoriesForUser(user: $0) }
    let flattened = allMems.flatMap { $0 }
    return flattened.sorted { $0.timestamp >= $1.timestamp }
  }
  
  func getFriendsMemoryPins(user: User) -> [ImageAnnotation] {
    let users = userController.getFriends(user: user)
    let allPins = users.map { self.getMemoryPinsForUser(user: $0) }
    return allPins.flatMap { $0 }
  }
  
  func getFriendsMemoriesForLocation(user: User, loc: Place) -> [Memory] {
    let allMems = self.getFriendsMemories(user: user)
    let filtered = allMems.filter { $0.location == loc.id }
    return filtered.sorted { $0.timestamp >= $1.timestamp }
  }
  
  func getImageFromURL(url: String) -> UIImage {
    if let (_, image): (String, UIImage) = (self.images.first { $0.0 == url }) {
      return image
    }
    return UIImage()
  }
  
  func saveMemory(caption: String, front: UIImage, back: UIImage, location: String) {
    let id = UUID().uuidString
    let newfront =  uploadPhoto(front)
    let newback =  uploadPhoto(back)
    let time = Date() // format is 2022-11-10 04:30:39 +0000
    let username = "kwgao" // later on make this username of curr user
    
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
  
  func timeToStr(timestamp: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "en_US")
    
    let timeFormatter = DateFormatter()
    timeFormatter.dateStyle = .none
    timeFormatter.timeStyle = .short
    timeFormatter.locale = Locale(identifier: "en_US")
    
    let date = dateFormatter.string(from: timestamp)
    let time = timeFormatter.string(from: timestamp).lowercased()
    return date + " | " + time
  }

  
}
