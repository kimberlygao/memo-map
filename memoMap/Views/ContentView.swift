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
    @State private var showingPrompt = false
    @State private var showingCamera = false
    @State var ownView = true
    @State var findUser = false
    @State private var showingSheet = false
    @State private var mapButtonColor  = Color.blue
    @State private var promptButtonColor  = Color.black
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if showingPrompt {
                    PromptMapWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController, userController: userController)
                } else {
                    MapViewWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController, ownView: self.$ownView, findUser: self.$findUser)
                    VStack { // vstack for components on top of map view
                        //            HStack {
                        //              NavigationLink(destination: AddFriendsView(userController: userController, memoryController: memoryController)) {
                        //                Image(systemName: "person.badge.plus")
                        //                  .padding(20)
                        //                  .font(.system(size: 24))
                        //                  .foregroundColor(.black)
                        //              }
                        //              Spacer()
                        //              NavigationLink(destination: ProfileView(user: userController.currentUser, userController: userController, memoryController: memoryController)) {
                        //                Image(systemName: "person.circle")
                        //                  .padding(20)
                        //                  .font(.system(size: 24))
                        //                  .foregroundColor(.black)
                        //              }
                        if !showingPrompt {
                            SearchView(mapViewController: mapViewController, searchController: searchController)
                        }
                        Spacer()
                        HStack (alignment: .bottom) {
                            Button(action: {ownView.toggle()}) {
                                VStack {
                                    let color1 : Color =  ownView ? .blue : .gray
                                    Image(systemName: "person")
                                        .font(.system(size: 24))
                                        .foregroundColor(color1)
                                        .padding(6)
                                        .padding(.top, 2)
                                    let color2 : Color =  ownView ? .gray : .blue
                                    Image(systemName: "globe.americas")
                                        .font(.system(size: 24))
                                        .foregroundColor(color2)
                                        .padding(6)
                                        .padding(.bottom, 2)
                                }
                            }
                            .background(Color("light"))
                            .cornerRadius(50)
                            
                            Spacer()
                            Button(action: {findUser.toggle()}) {
                                Image(systemName: "location")
                                    .font(.system(size: 24))
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(20)
                        Spacer()
                            .frame(height: 40)
                    }
                }
                
                VStack { // TAB BAR
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button (action : {
                            showingPrompt = false
                            mapButtonColor = .blue
                            promptButtonColor = .black
                        }) {
                            Image(systemName: "map")
                                .font(.system(size: 24))
                                .foregroundColor(mapButtonColor)
                        }
                        Spacer()
                        Button(action: {
                            showingCamera.toggle()
                        }) {
                            Image(systemName: "camera")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                        }
                        .fullScreenCover(isPresented: $showingCamera, content: {
                            //              CameraView(camera: camera, memoryController: memoryController, mapViewController : mapViewController)
                        })
                        Spacer()
                        Button (action : {
                            showingPrompt = true
                            promptButtonColor = .blue
                            mapButtonColor = .black
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 24))
                                .foregroundColor(promptButtonColor)
                        }
                        Spacer()
                    }
                    //          .padding(6)
                    .padding(.top, 12)
                    .background(.white)
                    .opacity(0.9)
                }
            }
            .sheet(isPresented: $showingSheet) {
                NavigationView {
                    LocationSheetView(memoryController: memoryController, place: placeController.places[0], userController: userController)
                }.presentationDetents([.medium, .large])
            }
            //      .onAppear(perform: {
            //        camera.check()
            //      })
            //
            
        }
    }
}
