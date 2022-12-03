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
  //  @State var showingAddFriends = false
  @State private var showingSheet = false
  
  var body: some View {
    NavigationView {
      ZStack {
        //        MapViewWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController)
        VStack {
          HStack {
            NavigationLink(destination: AddFriendsView(userController: userController, memoryController: memoryController)) {
              Image(systemName: "person.badge.plus")
                .padding(20)
                .font(.system(size: 24))
                .foregroundColor(.black)
            }
            Spacer()
            NavigationLink(destination: ProfileView(user: userController.currentUser, userController: userController, memoryController: memoryController)) {
              Image(systemName: "person.circle")
                .padding(20)
                .font(.system(size: 24))
                .foregroundColor(.black)
            }
          }
          HStack {
            Button (action: {showingSheet.toggle()}) {
              Image(systemName: "person.circle")
                .padding(28)
                .font(.system(size: 24))
                .foregroundColor(.black)
            }
          }
          Spacer()
        }
        VStack {
          Spacer()
          Button(action: {
            showingCamera.toggle()
          }) {
            Image(systemName: "camera")
              .font(.system(size: 32))
              .foregroundColor(.black)
          }
          .fullScreenCover(isPresented: $showingCamera, content: {
            CameraView(camera: camera, memoryController: memoryController, mapViewController : mapViewController)
          })
        }
      }
      .sheet(isPresented: $showingSheet) {
        NavigationView {
          RecentsSheetView(memoryController: memoryController, userController: userController)
        }.presentationDetents([.medium, .large])
      }
      //      .onAppear(perform: {
      //        camera.check()
      //      })
      
      
    }
  }
}
