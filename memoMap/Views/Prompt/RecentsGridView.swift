//
//  RecentsGridView.swift
//  memoMap
//
//  Created by Kimberly Gao on 12/3/22.
//

import SwiftUI

struct RecentsGridView: View {
  @ObservedObject var memoryController: MemoryController
  @ObservedObject var userController : UserController
  
  var threeColumnGrid = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]
  
  var body: some View {
    let memories = memoryController.getMemoriesForUser(user: userController.currentUser)
    GeometryReader { geo in
      ScrollView {
        LazyVGrid(columns: threeColumnGrid, spacing: 5) {
          ForEach(memories, id: \.self) { mem in
//            if let uiImage = image {
            NavigationLink (destination: PromptSelectView(memoryController: memoryController, memory: mem)){
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
