//
//  RecentsSheetView.swift
//  memoMap
//
//  Created by Kimberly Gao on 12/3/22.
//

import SwiftUI

struct RecentsSheetView: View {
  @Environment(\.dismiss) var dismiss
  
  @ObservedObject var memoryController: MemoryController
  @ObservedObject var userController : UserController
  @ObservedObject var dailyController : DailyPromptController
    @ObservedObject var promptController: PromptController
    @Binding var answered : Bool
    @Binding var isRecentSheetOpen : Bool
  
  var body: some View {
    VStack(alignment: .leading){
      Text("Recents")
        .font(.system(size: 20))
        .fontWeight(.bold)
      
      Spacer()
             .frame(height: 20)
      
//        RecentsGridView(memoryController: memoryController, userController: userController, dailyController: dailyController, promptController: promptController, answered: self.$answered, isRecentSheetOpen: self.$isRecentSheetOpen)
    }
    .padding(20)
    .padding(.top, 10)
  }
}
