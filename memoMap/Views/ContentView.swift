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
  @StateObject var camera = CameraController()
  @State private var showingAlert = false
  
  var body: some View {
    TabView {
      MapView(viewController: viewController)
        .tabItem {
          Image(systemName: "map")
      }.ignoresSafeArea()
      CameraView(camera: camera, memoryController: memoryController)
        .tabItem {
          Image(systemName: "camera")
      }
      MapView(viewController: viewController)
        .tabItem {
          Image(systemName: "mappin.circle")
      }
      
    }
    .onAppear(perform: {
      camera.check()
    })
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
