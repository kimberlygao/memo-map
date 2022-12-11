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
  
  var body: some View {
    
    if (dailyController.blurredPrompt) {
      PromptMapView(selectedPin: self.$selectedPin, isBottomSheetOpen: self.$isBottomSheetOpen, mapViewController: mapViewController, memoryController: memoryController, findUser: self.$findUser, answered: self.$answered, feedView: self.$feedView)
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.all)
        .blur(radius: 8, opaque: false)
        .overlay(Overlay(promptController: promptController, dailyController: dailyController))
    } else {
      NavigationView {
        ZStack {
          // map view used to be here
          if (feedView) && ((selectedPin != nil) || (answered)) {
            VStack {
              Spacer()
                .frame(height: 70)
              PromptScrollView(memoryController: memoryController, promptController: promptController, dailyController: dailyController, userController: userController)
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
                    .font(.system(size: 20))
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                    .background(.white.opacity(0.8))
                  Spacer()
                }
              }
//              .background(.ultraThickMaterial)
              .background(.white.opacity(0.8))
              Spacer()
            }
          }
        }.sheet(isPresented: $promptController.showingRecents) {
          NavigationView {
            RecentsSheetView(memoryController: memoryController, userController: userController, dailyController: dailyController, promptController: promptController, answered: self.$answered)
            
          }.presentationDetents([.medium, .large])
        }
      }
    }
  }
}
