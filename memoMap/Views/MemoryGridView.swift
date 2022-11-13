//
//  MemoryGridView.swift
//  memoMap
//
//  Created by Chloe Chan on 11/11/22.
//

import SwiftUI

struct MemoryGridView: View {
  @ObservedObject var memoryController: MemoryController
  var threeColumnGrid = [GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(), spacing: 5)]
  
  var body: some View {
    //    ForEach(memoryController.images, id: \.self) { image in
    //      if let uiImage = image {
    //        GeometryReader { geo in
    //          Image(uiImage: uiImage)
    //            .resizable()
    //            .scaledToFill()
    //            .frame(width:  (geo.size.width - 10) / 3, height: (geo.size.width - 10) / 3)
    //        }
    //      }
    //    }
    
    GeometryReader { geo in
      ScrollView {
        LazyVGrid(columns: threeColumnGrid, spacing: 5) {
          ForEach(memoryController.images, id: \.self) { image in
            if let uiImage = image {
              Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (geo.size.width - 10) / 3, height: (geo.size.width - 10) / 3)
                .clipped()
            }
          }
        }
      }
    }.padding()
    
    
    
    
  }
}

//struct MemoryGridView_Previews: PreviewProvider {
//  static var previews: some View {
//    MemoryGridView(memoryController: memoryController)
//  }
//}
