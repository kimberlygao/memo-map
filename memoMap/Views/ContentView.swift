//
//  ContentView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import Cluster

struct ContentView: View {
  let viewController = ViewController()
  let memoryController = MemoryController()
  let searchController = SearchController()
  let userController = UserController()
    
  @StateObject var mapViewController = MapViewController()
  @StateObject var placeController = PlaceController()
  @StateObject var camera = CameraController()
  @State private var showingAlert = false
  @State private var showingCamera = false
//    @State private
    @State private var blurredPrompt : Bool = false
  //  @State var showingAddFriends = false
  
  var body: some View {
      TabView {
          NavigationView {
            ZStack {
              // map view used to be here
                MapViewWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController)
                    .navigationBarTitleDisplayMode(.inline)
                    .edgesIgnoringSafeArea(.all)
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
                SearchView(mapViewController: mapViewController, searchController: searchController)
                Spacer()
              }
//              VStack {
//                Spacer()
//                Button(action: {showingCamera.toggle()}) {
//                  Image(systemName: "camera")
//                }
//                .fullScreenCover(isPresented: $showingCamera, content: {
//                  CameraView(camera: camera, memoryController: memoryController, mapViewController : mapViewController)
//                })
//              }
            }
      //      .onAppear(perform: {
      //        camera.check()
      //      })
            
            
          }.tabItem {
              Label("World", systemImage: "map")
          }
          
          CameraView(camera: camera, memoryController: memoryController, mapViewController : mapViewController)
              .tabItem {
                  Label("Camera", systemImage: "camera")
              }
          
          PromptView()
              .tabItem {
                  Label("Friends", systemImage: "map")
              }
      }
  }
}
