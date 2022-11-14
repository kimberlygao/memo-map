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
  @Published var newplace : Place = Place(id: "initial", address: "initial", city: "initial", latitude: 0, longitude: 0, name: "initial")
  
  init() {
    self.placeRepository.get({(places) -> Void in
      let place = places.randomElement()
      if let place = place {
        self.newplace = place
      }
      self.places = places
    })
  }
  
  func getPlaceData() {
    self.placeRepository.get({(places) -> Void in
      let place = places.randomElement()
      if let place = place {
        self.newplace = place
      }
      self.places = places
    })
  }
}
