//
//  PromptScrollView.swift
//  memoMap
//
//  Created by Kimberly Gao on 12/3/22.
//

import SwiftUI

struct PromptScrollView: View {
  
  let memoryController : MemoryController
  let promptController : PromptController
  let dailyController : DailyPromptController
  let userController : UserController
  
    var body: some View {
      GeometryReader { geo in
        ScrollViewReader { value in
          ScrollView {
            ForEach(memoryController.getFriendsDailys(user: userController.currentUser), id: \.self) { mem in
    //            if let uiImage = image {
                VStack {
                  SingleMemoryView(memoryController: memoryController, bigImage: memoryController.getImageFromURL(url: mem.back), smallImage: memoryController.getImageFromURL(url: mem.front), memory: mem, friendMemory: true, showLocation: true)
              }
                .frame(height: (geo.size.height - 0))
                .padding(.top, 15)
                .padding(.bottom, 15)
            }
          }.onAppear(
//            perform: {value.scrollTo(scrollId)}
          )

        }
      }
    }
}
