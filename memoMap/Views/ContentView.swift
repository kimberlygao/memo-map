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
  let promptController = PromptController()
  let dailyController = DailyPromptController()
  @State private var showingPrompt = false
  @State private var showingCamera = false
  @State var ownView = true
  @State var findUser = false
  @State private var showingSheet = false
  @State private var mapButtonColor  = Color("bold")
  @State private var promptButtonColor  = Color.black
  @State var answered = false
  
  
  var body: some View {
    NavigationView {
      ZStack {
        
        if showingPrompt {
            PromptMapWrapper(viewController: viewController, memoryController: memoryController, searchController: searchController, userController: userController, mapViewController: mapViewController, promptController: promptController, dailyController: dailyController, findUser: self.$findUser, answered: self.$answered)
        } else {
            MapViewWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController, userController: userController, placeController: placeController, ownView: self.$ownView, findUser: self.$findUser)
          VStack { // vstack for components on top of map view
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
            if !showingPrompt {
              SearchView(mapViewController: mapViewController, searchController: searchController)
            }
            Spacer()
            HStack (alignment: .bottom) {
              Button(action: {ownView.toggle()}) {
                VStack {
                  let color1 : Color =  ownView ? Color("bold") : .white
                  Image(systemName: "person")
                    .font(.system(size: 24))
                    .foregroundColor(color1)
                    .padding(6)
                    .padding(.top, 2)
                  let color2 : Color =  ownView ? .white : Color("bold")
                  Image(systemName: "globe.americas")
                    .font(.system(size: 24))
                    .foregroundColor(color2)
                    .padding(6)
                    .padding(.bottom, 2)
                }
              }
              .background(Color("pastel"))
              .cornerRadius(50)
              
              Spacer()
                Button(action: {findUser.toggle()}) {
                Image(systemName: "location")
                  .font(.system(size: 24))
                  .foregroundColor(Color("bold"))
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
              mapButtonColor = Color("bold")
              promptButtonColor = .black
            }) {
              Image(systemName: "map")
                .font(.system(size: 24))
                .foregroundColor(mapButtonColor)
            }
            Spacer()
            Button(action: {
              showingCamera.toggle()
              camera.start()
            }) {
              Image(systemName: "camera")
                .font(.system(size: 24))
                .foregroundColor(.black)
            }
            .fullScreenCover(isPresented: $showingCamera, content: {
              CameraView(camera: camera, memoryController: memoryController, mapViewController : mapViewController)
            })
            Spacer()
            Button (action : {
              showingPrompt = true
              promptButtonColor = Color("bold")
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
//      .onAppear(perform: {
//          camera.check()
//      })

      
    }
    .accentColor(Color("bold"))
  }
}
