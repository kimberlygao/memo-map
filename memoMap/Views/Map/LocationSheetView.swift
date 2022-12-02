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
  @ObservedObject var userController: UserController
  
  var body: some View {
    VStack(alignment: .leading){
      Text("Delanie's Coffee")
        .font(.system(size: 20))
        .fontWeight(.bold)
      Text("2002 Smallman St, Pittsburgh, PA 15122")
        .foregroundColor(.gray)
        .font(.system(size: 16))
      
      Spacer()
             .frame(height: 20)
      
      MemoryGridView(memoryController: memoryController, userController: userController)
    }
    .padding(20)
  }
}
