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
  @ObservedObject var userController = UserController()
  @StateObject var mapViewController = MapViewController()
  @StateObject var placeController = PlaceController()
  @StateObject var camera = CameraController()
  @State private var showingAlert = false
  @State private var showingCamera = false
  //  @State var showingAddFriends = false
  
  var body: some View {
    NavigationView {
      ZStack {
        MapView(mapViewController: mapViewController, placeController: placeController).ignoresSafeArea()
        VStack {
          HStack {
            NavigationLink(destination: AddFriendsView(userController: userController)) {
              Image(systemName: "person.badge.plus")
                .padding()
                .font(.system(size: 24))
                .foregroundColor(.black)
            }
            Spacer()
            NavigationLink(destination: MemoryGridView(memoryController: memoryController)) {
              Image(systemName: "checkmark")
                .padding()
                .font(.system(size: 24))
                .foregroundColor(.black)
            }
          }
          SearchView(mapViewController: mapViewController)
          Spacer()
        }
        VStack {
          Spacer()
          Button(action: {showingCamera.toggle()}) {
            Image(systemName: "camera")
          }
          .fullScreenCover(isPresented: $showingCamera, content: {
            CameraView(camera: camera, memoryController: memoryController, mapViewController: mapViewController)
          })
        }
      }
    }
    .onAppear(perform: {
      camera.check()
    })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
