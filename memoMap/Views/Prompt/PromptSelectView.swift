//
//  PromptSelectView.swift
//  memoMap
//
//  Created by Kimberly Gao on 12/3/22.
//

import SwiftUI

struct PromptSelectView: View {
  var memoryController : MemoryController
  var memory : Memory
    @Binding var answered : Bool
  @ObservedObject var dailyController : DailyPromptController
    @ObservedObject var promptController: PromptController
  var user : User
  
    var body: some View {
      VStack {
        GeometryReader { geo in
          SingleMemoryView(memoryController: memoryController, bigImage: memoryController.getImageFromURL(url: memory.back), smallImage: memoryController.getImageFromURL(url: memory.front), memory: memory, friendMemory: false, showLocation: true)
            .frame(height: (geo.size.height - 30))
        }
        Button (action: {
          dailyController.selectAnswer(user: user, memory: memory)
            answered.toggle()
            promptController.showingRecents.toggle()
          print("MEMORIES")
          print(memoryController.memories)
        }) {
          Text("Select Memory")
        }
        Spacer()
      }
    }
}


