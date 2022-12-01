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
                  MapViewWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController)
                }
                VStack {
//                    HStack {
//                        NavigationLink(destination: AddFriendsView()) {
//                            Image(systemName: "person.badge.plus")
//                                .padding()
//                                .font(.system(size: 24))
//                                .foregroundColor(.black)
//                        }
//                        Spacer()
//                        NavigationLink(destination: MemoryGridView(memoryController: memoryController)) {
//                            Image(systemName: "checkmark")
//                                .padding()
//                                .font(.system(size: 24))
//                                .foregroundColor(.black)
//                        }
//                    }
//                    SearchView(mapViewController: mapViewController, searchController: searchController)
                    Spacer()
                }
                VStack {
                    Spacer()
                    Button(action: {showingCamera.toggle()}) {
                        Image(systemName: "camera")
                    }
                    .fullScreenCover(isPresented: $showingCamera, content: {
                        CameraView(camera: camera, memoryController: memoryController, mapViewController : mapViewController)
                    })
                }
            }
                .onAppear(perform: {
                  camera.check()
                })
            
            
            
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
}
