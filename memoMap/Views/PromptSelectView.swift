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
  
    var body: some View {
      VStack {
        GeometryReader { geo in
          SingleMemoryView(memoryController: memoryController, bigImage: memoryController.getImageFromURL(url: memory.back), smallImage: memoryController.getImageFromURL(url: memory.front), memory: memory, friendMemory: false, showLocation: false)
            .frame(height: (geo.size.height - 30))
        }
        Button (action: {}) {
          Text("Select Memory")
        }
        Spacer()
      }
    }
}


