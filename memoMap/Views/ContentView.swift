//
//  ContentView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI

struct ContentView: View {
  let viewController = ViewController()
  let memoryController = MemoryController()
  @ObservedObject var placeController = PlaceController()
  @ObservedObject var userController = UserController()
//  @StateObject var camera = CameraController()
  @State private var showingAlert = false
  
  
  var body: some View {
    Text(userController.currentUser.password)
    Spacer()
    ForEach(memoryController.getMemoryPinsFromUser(user: userController.currentUser), id: \.self) { mem in
      Text(mem.url)
      if let uiImage = mem.image {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFit()
          .frame(width: 250, height: 250)
      } else {
        Text("no image")
      }
    }
    Text(placeController.getPlaceFromID(id: "1").name)
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
