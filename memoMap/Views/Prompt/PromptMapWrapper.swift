//
//  PromptMapWrapper.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI

struct Overlay: View {
    let promptController : PromptController
    @ObservedObject var dailyController : DailyPromptController
    @Binding var isRecentSheetOpen: Bool
  @Binding var minHeight : CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hidden Content")
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .font(.title)
            
            Spacer()
                .frame(height: 10)
            
            Text("Answer today’s prompt to")
                .multilineTextAlignment(.center)
            Text("view your friends map.")
                .multilineTextAlignment(.center)
            
            Spacer()
            Text(promptController.currPrompt)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 200, height: 200)
                .background(Color("bold"))
                .clipShape(Circle())
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                dailyController.blurredPrompt.toggle()
                isRecentSheetOpen.toggle()
                minHeight = 200.0
            }) {
                Text("Pick a Memory")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color("bold"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
}



struct PromptMapWrapper: View {
    let viewController : ViewController
    let memoryController : MemoryController
    let searchController : SearchController
    let userController : UserController
    let mapViewController : MapViewController
    @ObservedObject var promptController : PromptController
    @ObservedObject var dailyController : DailyPromptController
    @State var isBottomSheetOpen: Bool = false
    @State var selectedPin: ImageAnnotation? = nil
    @Binding var findUser: Bool
    @Binding var answered : Bool
    @State var feedView = false
    //    @Binding var showingRecents : Bool
    @State var isRecentSheetOpen: Bool = false
    var threeColumnGrid = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]
  @State var minHeight : CGFloat = 0.0
    
    
    var body: some View {
        let memories = memoryController.getMemoriesForUser(user: userController.currentUser)
        //        Button("hello", action: {
        //            print("memories", memories)
        //        })
      GeometryReader { geo in
            ZStack(alignment: .top) {
                VStack {
                  RecentDetailView(isOpen: self.$isRecentSheetOpen, maxHeight: geo.size.height * 0.8, minHeight: self.$minHeight) {
                      VStack(alignment: .leading){
                        HStack {
                          Text("Recents")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                          Spacer()
                        }
                        Spacer()
                          .frame(height: 20)
                        if self.isRecentSheetOpen {
                          GeometryReader { geometry in
                            ScrollView {
                              LazyVGrid(columns: threeColumnGrid, spacing: 5) {
                                ForEach(memories, id: \.self) { mem in
                                  NavigationLink (destination: PromptSelectView(memoryController: memoryController, memory: mem, answered: self.$answered, dailyController: dailyController, promptController: promptController, isRecentSheetOpen: self.$isRecentSheetOpen, user: userController.currentUser)){
                                    Image(uiImage: memoryController.getImageFromURL(url: mem.back))
                                      .resizable()
                                      .aspectRatio(contentMode: .fill)
                                      .frame(width: (geometry.size.width - 10) / 3, height: (geometry.size.width - 10) / 3)
                                      .clipped()
                                  }
                                }
                              }
                            }
                          }
                        }
                        Spacer()
                      }
                        .padding(20)
                        .padding(.top, 10)
                        
                    }
                }

                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
                
                
                if (dailyController.blurredPrompt) {
                    PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, memoryController: memoryController, findUser: self.$findUser, answered: self.$answered, feedView: self.$feedView)
                        .navigationBarTitleDisplayMode(.inline)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 8, opaque: false)
                        .overlay(Overlay(promptController: promptController, dailyController: dailyController, isRecentSheetOpen: self.$isRecentSheetOpen, minHeight: self.$minHeight))
                } else {
                    NavigationView {
                        ZStack {
                            if (feedView) && ((selectedPin != nil) || (answered)) {
                                VStack {
                                    Spacer()
                                        .frame(height: 70)
                                  PromptScrollView(memoryController: memoryController, promptController: promptController, dailyController: dailyController, userController: userController, selectedPin: self.$selectedPin)
                                    Spacer()
                                        .frame(height: 40)
                                }
                            }
                            else {
                                ZStack {
                                    PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, memoryController: memoryController, findUser: self.$findUser, answered: self.$answered, feedView: self.$feedView)
                                        .navigationBarTitleDisplayMode(.inline)
                                        .edgesIgnoringSafeArea(.all)
                                    
                                    if !answered {
                                        VStack (alignment: .leading) {
                                            HStack {
                                                Text("Pick a Memory")
                                                    .fontWeight(.bold)
                                                    .font(.title)
                                                Spacer()
                                            }
                                            HStack {
                                                Text(promptController.currPrompt)
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                        .padding(20)
                                    }
                                    
                                }
                            }
                            if (answered) {
                                VStack {
                                    VStack {
                                        HStack {
                                            Spacer()
                                                .background(.white.opacity(0.8))
                                            Button(action: {feedView.toggle()}) {
                                                let color1 : Color =  feedView ? Color("bold") : .white
                                                let color2 : Color =  feedView ? .white : Color("bold")
                                                Text("Map")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(color1)
                                                    .padding(8)
                                                    .padding(.leading, 8)
                                                    .padding(.trailing, 8)
                                                    .background(color2)
                                                    .cornerRadius(10)
                                                
                                                Text("Feed")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(color2)
                                                    .padding(8)
                                                    .padding(.leading, 8)
                                                    .padding(.trailing, 8)
                                                    .background(color1)
                                                    .cornerRadius(10)
                                                
                                            }
                                            .background(.white)
                                            .cornerRadius(10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("bold"), lineWidth: 1)
                                            )
                                            Spacer()
                                                .background(.white.opacity(0.8))
                                        }
                                        .padding(.bottom, 5)
                                        .background(.white.opacity(0.8))
                                        
                                        HStack {
                                            Text(promptController.currPrompt)
                                                .fontWeight(.bold)
                                                .font(.system(size: 18))
                                                .padding(.leading, 20)
                                                .padding(.bottom, 10)
                                                .background(.white.opacity(0.8))
                                            Spacer()
                                        }
                                    }
                                    //              .background(.ultraThickMaterial)
                                    .background(.white)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                //        .sheet(isPresented: $promptController.showingRecents) {
                //          NavigationView {
                //            RecentsSheetView(memoryController: memoryController, userController: userController, dailyController: dailyController, promptController: promptController, answered: self.$answered)
                //
                //          }.presentationDetents([.medium, .large])
                //        }
            }
        }
    }
}
//}

