//
//  LocationController.swift
//  memoMap
//
//  Created by Chloe Chan on 11/9/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class LocationController: ObservableObject {
  @Published var locations: [Location] = LocationRepository().locations
  @Published var location: Location = Location(id: "", address: "", city: "", latitude: 0, longitude: 0, name: "")
  
  init() {
    getLocationData(id: "WDh4Ypy1PkNoC2u8JzcG")
  }
  
  func getLocationData(id: String) {
    let docRef = Firestore.firestore().collection("locations").document(id)
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//        print("Document data: \(dataDescription)")
        
        let data = document.data()
        
        let address = data!["address"]! as? String ?? ""
        let city = data!["city"]! as? String ?? ""
        let latitude = data!["latitude"]! as? Float ?? 0.0
        let longitude = data!["longitude"]! as? Float ?? 0.0
        let name = data!["name"]! as? String ?? ""
        
        self.location = Location(id: id, address: address, city: city, latitude: latitude, longitude: longitude, name: name)
        
      } else {
        print("Document does not exist")
      }
    }
  }
}
