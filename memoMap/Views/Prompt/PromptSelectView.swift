//
//  PromptSelectView.swift
//  memoMap
//
//  Created by Kimberly Gao on 12/3/22.
//

import SwiftUI

struct PromptSelectView: View {
  var memoryController: MemoryController
  var memory: Memory
    @Binding var answered : Bool
  @ObservedObject var dailyController: DailyPromptController
    @ObservedObject var promptController: PromptController
    @Binding var isRecentSheetOpen : Bool
  var user : User
  
    var body: some View {
      VStack {
        GeometryReader { geo in
          SingleMemoryView(memoryController: memoryController, bigImage: memoryController.getImageFromURL(url: memory.back), smallImage: memoryController.getImageFromURL(url: memory.front), memory: memory, friendMemory: false, showLocation: true)
            .frame(height: (geo.size.height))
        }
        Button (action: {
          dailyController.selectAnswer(user: user, memory: memory)
            answered.toggle()
            isRecentSheetOpen.toggle()
            promptController.showingRecents.toggle()
        }) {
          Text("Select Memory")
            .padding(12)
            .padding(.leading, 4)
            .padding(.trailing, 4)
            .foregroundColor(.white)
            .background(Color("bold"))
            .cornerRadius(10)
            .font(.system(size: 18))
        }
        Spacer()
      }
    }
}


