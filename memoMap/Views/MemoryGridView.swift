//
//  MemoryGridView.swift
//  memoMap
//
//  Created by Chloe Chan on 11/11/22.
//

import SwiftUI

struct MemoryGridView: View {
  @ObservedObject var memoryController: MemoryController
  @ObservedObject var userController: UserController
  var threeColumnGrid = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]
  
  var body: some View {
    ScrollView {
      ForEach(memoryController.getFriendsMemoryPins(user: userController.currentUser), id: \.self) { pin in
        Text(pin.url)
      }
    }
    
    
    //    GeometryReader { geo in
    //      ScrollView {
    //        LazyVGrid(columns: threeColumnGrid, spacing: 5) {
    //          ForEach(memoryController.images, id: \.self) { image in
    //            if let uiImage = image {
    //              NavigationLink (destination: MemoryScrollView(memoryController: memoryController)){
    //                Image("kwgao")
    //                  .resizable()
    //                  .aspectRatio(contentMode: .fill)
    //                  .frame(width: (geo.size.width - 10) / 3, height: (geo.size.width - 10) / 3)
    //                  .clipped()
    //              }
    //
    //            }
    //          }
    //        }
    //      }
    //    }
    
    
    
    
  }
}
