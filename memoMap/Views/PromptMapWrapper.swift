//
//  PromptMapWrapper.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/12/1.
//

import SwiftUI


struct Overlay: View {
    @Binding var blurredPrompt : Bool
    var body: some View {
        VStack {
            Spacer()
            Text("Hidden Content").multilineTextAlignment(.center)
            Text("Answer today’s prompt to view the friends map.").multilineTextAlignment(.center)
            Spacer()
            Text("Somewhere you would rather be in this moment")
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 200, height: 200)
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
            Spacer()
            Button(action: {blurredPrompt.toggle()}) {
                Text("Pick a Memory")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding()
                    .cornerRadius(50.0)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        //            .opacity(0.8)
        //            .cornerRadius(50.0)
        //            .padding(6)
    }
}

struct PromptMapWrapper: View {
    @State private var showingSheet = true
    @ObservedObject var memoryController: MemoryController
    let mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @ObservedObject var userController: UserController
    @State private var selectedPlace: ImageAnnotation?
    @State var isBottomSheetOpen: Bool = false
    @State var selectedPin: ImageAnnotation? = nil
    @Binding var findUser: Bool
    @State var blurredPrompt = true
    
    
    var body: some View {
        if blurredPrompt {
            PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, findUser: self.$findUser)
                .navigationBarTitleDisplayMode(.inline)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 8, opaque: false)
                .overlay(Overlay(blurredPrompt: $blurredPrompt))
        } else {
            NavigationView {
                ZStack {
                    // map view used to be here
                    PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, findUser: self.$findUser)
                        .navigationBarTitleDisplayMode(.inline)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        HStack {
                            NavigationLink(destination: AddFriendsView(userController: userController)) {
                                Image(systemName: "person.badge.plus")
                                    .padding()
                                    .font(.system(size: 24))
                                    .foregroundColor(.black)
                            }
                            Spacer()
//                            NavigationLink(destination: MemoryGridView(memoryController: memoryController)) {
//                                Image(systemName: "checkmark")
//                                    .padding()
//                                    .font(.system(size: 24))
//                                    .foregroundColor(.black)
//                            }
                        }
                        Spacer()
                    }
                }.sheet(isPresented: $showingSheet) {
                    NavigationView {
//                        MemoryGridView(memoryController: memoryController)
                        
                        
                    }.presentationDetents([.medium, .large])
                }
            }
        }
//        ZStack(alignment: .top) {
//            //            VStack {
//            //                LocationSheetView(isOpen: self.$showingSheet, memoryController: memoryController)
//            //            }
//            //            .edgesIgnoringSafeArea(.all)
//            //            .zIndex(1)
//
//
////            MapView(mapViewController: mapViewController, searchController: searchController, memoryController: memoryController, annotations: searchController.annotations, currMemories: mapViewController.currMemories, selectedPin: self.$selectedPin,
////                    isBottomSheetOpen: self.$isBottomSheetOpen, ownView: <#T##Binding<Bool>#>
////            )
//            PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, findUser: self.$findUser)
//            .navigationBarTitleDisplayMode(.inline)
//            .edgesIgnoringSafeArea(.all)
//            Spacer()
//        }.sheet(isPresented: Binding<Bool>(get: { !blurredSheet },
//                                           set: { blurredSheet = !$0 })) {
//            NavigationView {
////                MemoryGridView(memoryController: memoryController)
////                LocationSheetView(memoryController: memoryController, place: self.selectedPin, userController: userController)
//
//
//            }.presentationDetents([.medium, .large])
//        }
    }
}

//struct PromptMapWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        PromptMapWrapper()
//    }
//}
