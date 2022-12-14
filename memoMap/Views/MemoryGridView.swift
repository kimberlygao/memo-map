//
//  MemoryGridView.swift
//  memoMap
//
//  Created by Chloe Chan on 11/11/22.
//

import SwiftUI

struct MemoryGridView: View {
  @ObservedObject var memoryController: MemoryController
  var place : Place
  @ObservedObject var userController : UserController
  @Binding var ownView: Bool
  
  var threeColumnGrid = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]
  
  var body: some View {
    let memories = ownView ? memoryController.getUserMemoriesForLocation(user: userController.currentUser, loc: place) : memoryController.getFriendsMemoriesForLocation(user: userController.currentUser, loc: place)
    GeometryReader { geo in
      ScrollView {
        LazyVGrid(columns: threeColumnGrid, spacing: 5) {
          ForEach(memories, id: \.self) { mem in
//            if let uiImage = image {
            NavigationLink (destination: MemoryScrollView(memoryController: memoryController, memories: memories, scrollId: mem, placeName: place.name, friendMemory: !ownView)){
                Image(uiImage: memoryController.getImageFromURL(url: mem.back))
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: (geo.size.width - 10) / 3, height: (geo.size.width - 10) / 3)
                  .clipped()
              }

//            }
          }
        }
      }
    }
    
    
    
    
  }
}
