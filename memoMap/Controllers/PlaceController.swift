//
//  PlaceController.swift
//  memoMap
//
//  Created by Chloe Chan on 11/9/22.
//
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PlaceController: ObservableObject {
  @Published var placeRepository: PlaceRepository = PlaceRepository()
  @Published var places : [Place] = []
  
  init() {
    self.placeRepository.get({(places) -> Void in
//      print("inside place controllllller", places)
      self.places = places
    })
  }
  
  func getPlaceFromID(id: String) -> Place {
    if let place: Place = (self.places.filter { $0.locid == id }).first {
      return place
    }
    print("no place found")
    return Place(address: "nil", city: "nil", latitude: 0.00, longitude: 0.00, name: "nil", locid: "nil")
  }
}
