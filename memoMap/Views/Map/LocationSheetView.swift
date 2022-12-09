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
  var place : ImageAnnotation
  @ObservedObject var userController : UserController
  
  var body: some View {
    VStack(alignment: .leading){
      Text(place.title ?? "")
        .font(.system(size: 20))
        .fontWeight(.bold)
      Text(place.address ?? "")
        .foregroundColor(.gray)
        .font(.system(size: 16))
      
      Spacer()
             .frame(height: 20)
//      
//      MemoryGridView(memoryController: memoryController, place: place, userController: userController)
    }
    .padding(20)
    .padding(.top, 10)
  }
}
