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
  @StateObject var mapViewController = MapViewController()
  @StateObject var placeController = PlaceController()
  @StateObject var camera = CameraController()
  @State private var showingAlert = false
  @State private var showingCamera = false
  @State var showingAddFriends = false
  
  var body: some View {
    ZStack {
      MapView(mapViewController: mapViewController, placeController: placeController).ignoresSafeArea()
      VStack {
        HStack {
          Button(action: {withAnimation {showingAddFriends.toggle()}}) {
            Image(systemName: "person.badge.plus")
              .padding()
              .font(.system(size: 24))
              .foregroundColor(.black)
          }
          Spacer()
        }
        Spacer()
      }
      VStack {
        Spacer()
        Button(action: {showingCamera.toggle()}) {
          Image(systemName: "camera")
        }
        .fullScreenCover(isPresented: $showingCamera, content: {
          CameraView(camera: camera, memoryController: memoryController)
        })
      }
    }.onAppear(perform: {
      camera.check()
    })
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .overlay(showingAddFriends ? AddFriendsView(showingFriends: $showingAddFriends.animation()) : nil)
    
    
    
    //    NavigationView {
    //      TabView {
    //        ZStack {
    //          MapView(mapViewController: mapViewController, placeController: placeController).ignoresSafeArea()
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
    //            SearchView(mapViewController: mapViewController)
    //            Spacer()
    //          }
    //        }.tabItem {
    //          Image(systemName: "map")
    //        }
    //        CameraView(camera: camera, memoryController: memoryController)
    //          .tabItem {
    //            Image(systemName: "camera")
    //        }
    //        MapView(mapViewController: mapViewController, placeController: placeController)
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
