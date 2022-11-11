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
//  @StateObject var camera = CameraController()
  @State private var showingAlert = false
  
  var body: some View {
    NavigationView {
      TabView {
        ZStack {
          MapView(mapViewController: mapViewController, placeController: placeController).ignoresSafeArea()
          VStack {
            HStack {
              NavigationLink(destination: AddFriendsView()) {
                Image(systemName: "person.badge.plus")
                  .padding()
                  .font(.system(size: 24))
                  .foregroundColor(.black)
              }
              Spacer()
            }
            SearchView(mapViewController: mapViewController)
            Spacer()
          }
        }.tabItem {
          Image(systemName: "map")
        }
//        CameraView(camera: camera, memoryController: memoryController)
//          .tabItem {
//            Image(systemName: "camera")
//        }
        MapView(mapViewController: mapViewController, placeController: placeController)
          .tabItem {
            Image(systemName: "mappin.circle")
        }
        
      }
    }
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
