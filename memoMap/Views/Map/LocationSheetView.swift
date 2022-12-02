//
//  LocationSheetView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/30.
//

import SwiftUI

struct LocationSheetView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var memoryController: MemoryController
  
  var body: some View {
    VStack(alignment: .leading){
      Text("Recents")
        .font(.system(size: 20))
        .fontWeight(.bold)
      Spacer()
             .frame(height: 20)
      
      MemoryGridView(memoryController: memoryController)
    }
    .padding(20)
  }
}
