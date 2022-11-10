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
  @Published var newplace: String = "initial" // = "intial"// = Place(id: "", address: "", city: "", latitude: 0, longitude: 0, name: "")
  
//  init() {
////    getPlaceData(id: "1")
//    self.placeRepository = PlaceRepository()
//    self.newplace = "initial"
//  }
  
  func getPlaceData() {
    self.placeRepository.get({(places) -> Void in
      let place = places.randomElement()
      if let place = place {
        self.newplace = place.name
      }
//      let places = places
//      if let places = places {
//        self.places = places
//      } else {
//        self.places = []
//      }
    })
  }
  
//  func getPlaceData(id: String) {
//    let docRef = Firestore.firestore().collection("places").document(id)
//    docRef.getDocument { (document, error) in
//      if let document = document, document.exists {
//        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
////        print("Document data: \(dataDescription)")
//
//        let data = document.data()
//
//        let address = data!["address"]! as? String ?? ""
//        let city = data!["city"]! as? String ?? ""
//        let latitude = data!["latitude"]! as? Double ?? 0.00
//        let longitude = data!["longitude"]! as? Double ?? 0.00
//        let name = data!["name"]! as? String ?? ""
//
//        self.place = Place(id: id, address: address, city: city, latitude: latitude, longitude: longitude, name: name)
//
//      } else {
//        print("Document does not exist")
//      }
//    }
//  }
}
