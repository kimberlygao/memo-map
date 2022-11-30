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
  var memoryRepository : MemoryRepository = MemoryRepository()
  @Published var placeController : PlaceController = PlaceController()
  @Published var memories: [Memory] = []
  //  @Published var memory: Memory = Memory(id: "", caption: "", front: "", back: "", location: "", username: "", timestamp: Date())
  @Published var currImage: UIImage = UIImage()
  
  init() {
    // get all memories
    self.memoryRepository.get({(memories) -> Void in
      self.memories = memories
    })
    self.retrievePhoto({(image) -> Void in
      self.currImage = image
      print("self.currimage init", self.currImage)
    }, "default.jpeg")
  }
  
  func getMemoriesForUser(user: User) -> [Memory] {
    return self.memories.filter { $0.username == user.id }
  }
  
  
  func getMemoryPinsFromUser(user: User) -> [ImageAnnotation] {
    let memories: [Memory] = getMemoriesForUser(user: user)
    var pins: [ImageAnnotation] = []
    
    for mem in memories {
      let place = placeController.getPlaceFromID(id: mem.location)
      let coords = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
      let locAnnotation = LocationAnnotation(title: place.name, subtitle: "none", coordinate: coords)
      
      print("self.currimage  before pins", self.currImage)
      self.retrievePhoto({ (image) in
        self.currImage = image
        print("self.currimage  after pins", self.currImage)
        let pin = ImageAnnotation(id: UUID().uuidString, locAnnotation: locAnnotation, isMemory: true, url: mem.back, image: self.currImage)
        pins.append(pin)
      }, mem.back)
      
      
//      let pin = ImageAnnotation(id: mem.id!, locAnnotation: locAnnotation, isMemory: true, url: mem.back, image: img)
      
    
      
    }
    return pins
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
  
  func retrievePhoto(_ completionHandler: @escaping (_ image: UIImage) -> Void, _ url: String) -> Void {
    let storage = Storage.storage()
    let ref = storage.reference().child(url)
    // look into having callbacks update a published var
    // and then have the viewmodel pick up when the published var has updated
    // to then send back to the view
    ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        print("Error retrieving photo: \(error)")
      } else {
        let image = UIImage(data: data!)
        completionHandler(image!)
      }
    }
  }
  
}
