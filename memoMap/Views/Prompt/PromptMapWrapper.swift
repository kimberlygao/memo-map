//
//  PromptMapWrapper.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI

struct Overlay: View {
  let promptController : PromptController
  @Binding var blurredPrompt : Bool
  
  var body: some View {
    
    //        Text("13")
    //          .padding()
    //          .overlay(
    //            Circle()
    //                .stroke(Color.blue, lineWidth: 4)
    //                .background(Color.blue)
    //              .padding(6)
    //          )
    VStack {
      Spacer()
      Text("Hidden Content").multilineTextAlignment(.center)
      Text("Answer today’s prompt to view the friends map.").multilineTextAlignment(.center)
      Spacer()
      Text(promptController.currPrompt)
        .font(.callout)
        .multilineTextAlignment(.center)
        .padding()
        .frame(width: 200, height: 200)
        .background(Color.blue)
        .clipShape(Circle())
        .foregroundColor(.white)
      Spacer()
      Button(action: {
        blurredPrompt.toggle()
      }) {
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
  let viewController : ViewController
  let memoryController : MemoryController
  let searchController : SearchController
  let userController : UserController
  let mapViewController : MapViewController
  let promptController : PromptController
  let dailyController : DailyPromptController
  @State private var showingSheet = true
  @State var isBottomSheetOpen: Bool = false
  @State var selectedPin: ImageAnnotation? = nil
  @Binding var findUser: Bool
  @State var blurredPrompt = true
  @State var answered = false
  @State var feedView = false
  
  var body: some View {
    
    if blurredPrompt {
      PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, memoryController: memoryController, findUser: self.$findUser, answered: self.$answered)
        .blur(radius: 8, opaque: false)
        .overlay(Overlay(promptController: promptController, blurredPrompt: $blurredPrompt))
    } else {
      NavigationView {
        ZStack {
          // map view used to be here
          PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, memoryController: memoryController, findUser: self.$findUser, answered: self.$answered)
          VStack {
            HStack {
              Button(action: {feedView.toggle()}) {
                let color1 : Color =  feedView ? .blue : .white
                let color2 : Color =  feedView ? .white : .blue
                Text("Map")
                  .font(.system(size: 12))
                  .foregroundColor(color1)
                  .padding(8)
                  .padding(.leading, 8)
                  .padding(.trailing, 8)
                  .background(color2)
                
                Text("Feed")
                  .font(.system(size: 12))
                  .foregroundColor(color2)
                  .padding(8)
                  .padding(.leading, 8)
                  .padding(.trailing, 8)
                  .background(color1)
                
              }
              .cornerRadius(10)
            }
            Spacer()
          }
        }.sheet(isPresented: $showingSheet) {
          NavigationView {
            RecentsSheetView(memoryController: memoryController, userController: userController, dailyController: dailyController, answered: self.$answered)
            
          }.presentationDetents([.medium, .large])
        }
      }
    }
  }
}
