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
      Text("placeholder")
      GeometryReader { geo in
        ScrollViewReader { value in
          ScrollView {
            ForEach(memoryController.getFriendsDailys(user: userController.currentUser), id: \.self) { mem in
    //            if let uiImage = image {
                VStack {
                  SingleMemoryView(memoryController: memoryController, bigImage: memoryController.getImageFromURL(url: mem.back), smallImage: memoryController.getImageFromURL(url: mem.front), memory: mem, friendMemory: true, showLocation: true)
              }
                .frame(height: (geo.size.height - 40))
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
          }.onAppear(
//            perform: {value.scrollTo(scrollId)}
          )

        }
      }
    }
}
