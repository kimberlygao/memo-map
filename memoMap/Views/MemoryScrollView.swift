//
//  MemoryScrollView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/29/22.
//

import SwiftUI

struct MemoryScrollView: View {
  @ObservedObject var memoryController : MemoryController

  var body: some View {
    GeometryReader { geo in

//            SingleMemoryView(memoryController: memoryController, bigImage: memoryController.images[0], smallImage: memoryController.images[1])
          }
    
//    GeometryReader { geo in
//      ScrollView {
//        VStack(spacing: 50) {
//          ForEach(0..<10) {_ in
//            SingleMemoryView(memoryController: memoryController, bigImage: memoryController.images[0], smallImage: memoryController.images[1])
//          }
//        }
//      }
//      .frame(height: (geo.size.height))
//    }
  }
}
