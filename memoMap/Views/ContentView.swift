//
//  ContentView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI

struct ContentView: View {
  let viewController: ViewController = ViewController()
  let cameraController: CameraController = CameraController()
  @State private var showingAlert = false
  
  var body: some View {
    CameraView(camera: cameraController)
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
   

    //    TabView {
    //      MapView(viewController: viewController)
    //        .tabItem {
    //          Image(systemName: "map")
    //      }.ignoresSafeArea()
    //      CameraView()
    //        .tabItem {
    //          Image(systemName: "camera")
    //      }
    //      MapView(viewController: viewController)
    //        .tabItem {
    //          Image(systemName: "mappin.circle")
    //      }
    //    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
