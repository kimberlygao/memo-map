////
////  PromptView.swift
////  memoMap
////
////  Created by Kimberly Gao on 11/2/22.
////
//
//import SwiftUI
//
//
//
//struct Overlay: View {
//    @Binding var blurredPrompt : Bool
//    var body: some View {
//        
//        //        Text("13")
//        //          .padding()
//        //          .overlay(
//        //            Circle()
//        //                .stroke(Color.blue, lineWidth: 4)
//        //                .background(Color.blue)
//        //              .padding(6)
//        //          )
//        VStack {
//            Spacer()
//            Text("Hidden Content").multilineTextAlignment(.center)
//            Text("Answer today’s prompt to view the friends map.").multilineTextAlignment(.center)
//            Spacer()
//            Text("Somewhere you would rather be in this moment")
//                .font(.callout)
//                .multilineTextAlignment(.center)
//                .padding()
//                .frame(width: 200, height: 200)
//                .background(Color.blue)
//                .clipShape(Circle())
//                .foregroundColor(.white)
//            Spacer()
//            Button(action: {blurredPrompt.toggle()}) {
//                Text("Pick a Memory")
//                    .font(.callout)
//                    .multilineTextAlignment(.center)
//                    .padding()
//                    .cornerRadius(50.0)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//            }
//            Spacer()
//        }
//        //            .opacity(0.8)
//        //            .cornerRadius(50.0)
//        //            .padding(6)
//    }
//}
//
//
//
//struct PromptView: View {
//    let viewController = ViewController()
//    let memoryController = MemoryController()
//    let searchController = SearchController()
//    let userController = UserController()
//    @State private var showingSheet = true
//    let mapViewController = MapViewController()
//    @State private var blurredPrompt = true
//    //    @State private var blurredPrompt = false
//    
//    var body: some View {
//        
//        if blurredPrompt {
//            PromptMapWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController, userController: userController)
//                .blur(radius: 8, opaque: false)
//                .overlay(Overlay(blurredPrompt: $blurredPrompt))
//        } else {
//            NavigationView {
//                ZStack {
//                    // map view used to be here
//                    PromptMapWrapper(memoryController: memoryController, mapViewController: mapViewController, searchController: searchController, userController: userController)
//                    VStack {
//                        HStack {
//                            NavigationLink(destination: AddFriendsView(userController: userController)) {
//                                Image(systemName: "person.badge.plus")
//                                    .padding()
//                                    .font(.system(size: 24))
//                                    .foregroundColor(.black)
//                            }
//                            Spacer()
////                            NavigationLink(destination: MemoryGridView(memoryController: memoryController)) {
////                                Image(systemName: "checkmark")
////                                    .padding()
////                                    .font(.system(size: 24))
////                                    .foregroundColor(.black)
////                            }
//                        }
//                        SearchView(mapViewController: mapViewController, searchController: searchController)
//                        Spacer()
//                    }
//                }.sheet(isPresented: $showingSheet) {
//                    NavigationView {
////                        MemoryGridView(memoryController: memoryController)
//                        
//                        
//                    }.presentationDetents([.medium, .large])
//                }
//            }
//        }
//    }
//}
//
////struct PromptView_Previews: PreviewProvider {
////    static var previews: some View {
////        PromptView()
////    }
////}
