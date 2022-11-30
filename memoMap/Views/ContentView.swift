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
  @State var memPins : [ImageAnnotation] = []
  @ObservedObject var placeController = PlaceController()
  @ObservedObject var userController = UserController()
//  @StateObject var camera = CameraController()
  @State private var showingAlert = false
  
  
  var body: some View {
    AddFriendsView(userController: userController)
    Text(userController.currentUser.password)
    Spacer()
//    ForEach(, id: \.self) { mem in
//      Text(mem.url)
//      if let uiImage = mem.image {
//        Image(uiImage: uiImage)
//          .resizable()
//          .scaledToFit()
//          .frame(width: 250, height: 250)
//          .border(Color.red)
//      } else {
//        Text("no image")
//      }
//    }
    List(memPins) { pin in
      if let uiImage = pin.image {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFit()
          .frame(width: 250, height: 250)
          .border(Color.red)
      } else {
        Text("no image")
      }
    }.task { await loadPins() }
    
    Text(placeController.getPlaceFromID(id: "1").name)
    
  }
  func loadPins() async {
    let pins = await memoryController.getMemoryPinsFromUser(user: userController.currentUser)
    self.memPins = pins
  }
}

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    ContentView()
//  }
//}
