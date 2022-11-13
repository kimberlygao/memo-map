//
//  MemoryGridView.swift
//  memoMap
//
//  Created by Chloe Chan on 11/11/22.
//

import SwiftUI

struct MemoryGridView: View {
  @ObservedObject var memoryController: MemoryController
  
  var body: some View {
    ForEach(memoryController.images, id: \.self) { image in
      if let uiImage = image {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFit()
          .frame(width: 250, height: 250)
      }
    }
  
    
    
    
  }
}



//struct MemoryGridView_Previews: PreviewProvider {
//  static var previews: some View {
//    MemoryGridView(memoryController: )
//  }
//}
