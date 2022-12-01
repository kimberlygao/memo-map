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
    @StateObject var mapViewController = MapViewController()
    @StateObject var placeController = PlaceController()
    @StateObject var camera = CameraController()
    @State private var showingAlert = false
    @State private var showingCamera = false
    //  @State var showingAddFriends = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // map view used to be here
                NavigationView {
                    MapViewWrapper(mapViewController: mapViewController, searchController: searchController)
                }
                VStack {
                    HStack {
                        NavigationLink(destination: AddFriendsView()) {
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
