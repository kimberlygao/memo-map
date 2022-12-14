//
//  MemoryScrollView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/29/22.
//

import SwiftUI

struct MemoryScrollView: View {
  @ObservedObject var memoryController : MemoryController
  var memories : [Memory]
  var scrollId : Memory
  var placeName : String
  @State var friendMemory : Bool

  var body: some View {
    GeometryReader { geo in
      ScrollViewReader { value in
        ScrollView {
            ForEach(memories, id: \.self) { mem in
  //            if let uiImage = image {
              VStack {
                SingleMemoryView(memoryController: memoryController, bigImage: memoryController.getImageFromURL(url: mem.back), smallImage: memoryController.getImageFromURL(url: mem.front), memory: mem, friendMemory: friendMemory, showLocation: false)
            }
              .frame(height: (geo.size.height - 80))
              .padding(.top, 20)
              .padding(.bottom, 15)
          }
        }.onAppear(
          perform: {value.scrollTo(scrollId)}
        )
      
      }
    }.navigationTitle(placeName)

    
//    GeometryReader { geo in

//            SingleMemoryView(memoryController: memoryController, bigImage: memoryController.images[0], smallImage: memoryController.images[1])
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
