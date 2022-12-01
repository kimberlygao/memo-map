//
//  ContentView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI

struct ContentView: View {
  let viewController = ViewController()
  @ObservedObject var memoryController = MemoryController()
  @ObservedObject var placeController = PlaceController()
  @ObservedObject var userController = UserController()
//  @StateObject var camera = CameraController()
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
            Button(action: {showingSheet.toggle()}){
              Image(systemName: "checkmark")
                .padding()
                .font(.system(size: 24))
                .foregroundColor(.black)
            }
            NavigationLink(destination: MemoryScrollView(memoryController: memoryController)) {
              Image(systemName: "person.badge.plus")
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
              .padding()
              .font(.system(size: 24))
              .foregroundColor(.black)
          }
          .fullScreenCover(isPresented: $showingCamera, content: {
            //            CameraView(camera: camera, memoryController: memoryController, mapViewController: mapViewController)
          })
        }
      }
    }
    //    .onAppear(perform: {
    //      camera.check()
    //    })
    .sheet(isPresented: $showingSheet) {
      NavigationView {
        LocationSheetView(memoryController: memoryController)
          
        
      }.presentationDetents([.medium, .large])
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
