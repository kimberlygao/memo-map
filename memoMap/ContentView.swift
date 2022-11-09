//
//  ContentView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
  @ObservedObject var userController = UserController()
  @ObservedObject var locationController = LocationController()
  @ObservedObject var memoryController = MemoryController()
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text(userController.user.name)
      Text(locationController.location.name)
      Text(memoryController.memory.caption)
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
