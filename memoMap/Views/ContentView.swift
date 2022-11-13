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
//  var friends: [User] = []
  
  
  var body: some View {
    Text("hi").onAppear {
      placeController.getPlaceData()
    }
    Text(placeController.newplace.name)
    Text(userController.currentUser.name)
    List {
      ForEach(userController.getFriends(user: userController.currentUser), id: \.self) { friend in
        Text(friend.name)
      }
    }
//    NavigationView {
//      TabView {
//        ZStack {
//          MapView(viewController: viewController).ignoresSafeArea()
//          VStack {
//            HStack {
//              NavigationLink(destination: AddFriendsView()) {
//                Image(systemName: "person.badge.plus")
//                  .padding()
//                  .font(.system(size: 24))
//                  .foregroundColor(.black)
//              }
//              Spacer()
//            }
//            Spacer()
//          }
//        }.tabItem {
//          Image(systemName: "map")
//        }
//        CameraView(camera: camera, memoryController: memoryController)
//          .tabItem {
//            Image(systemName: "camera")
//        }
//        MapView(viewController: viewController)
//          .tabItem {
//            Image(systemName: "mappin.circle")
//        }
//
//      }
//    }
//    .onAppear(perform: {
//      camera.check()
//    })
//
//    VStack {
//      MapView(viewController: viewController)
//
//      HStack {
////        Spacer()
////        Image(systemName: "map").padding()
////        Spacer()
////        Image(systemName: "mappin.circle")
////        Spacer()
//        NavigationLink {
//            CameraView(camera: cameraController)
//        } label: {
//          Image(systemName: "camera")
//        }
//      }
//    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
