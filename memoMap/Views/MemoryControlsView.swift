//
//  MemoryControlsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/6/22.
//

import SwiftUI

struct MemoryControlsView: View {
  @State private var selectedLocation = "one"
  @State private var caption: String = ""
  @StateObject var camera : CameraController
  @ObservedObject var memoryController : MemoryController
  
  var body: some View {
    VStack (alignment: .leading) {
      HStack {
        Image(systemName: "mappin.and.ellipse")
          .foregroundColor(.black)
          .font(.system(size: 30))
        Menu("Location") {
          Button("One", action: {})
          Button("Two", action: {})
          Button("Three", action: {})
        }.underline()
          .foregroundColor(.black)
      }
      
      TextField("Add a caption...", text: $caption)
      
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
//          memoryController.saveMemory(caption: caption, front: camera.photo1, back: camera.photo2, location: "1")
        },
               label: {
          Image(systemName: "paperplane")
            .foregroundColor(.black)
            .font(.system(size: 30))
            .rotationEffect(Angle(degrees: 45))
            .padding(.leading)
        })
      }
      .padding(.bottom, 10)
      
      Spacer()
      
    }
    .padding()
    .padding(.bottom, 20)
    .frame(height: 350)
  }
}

//
//struct MemoryControlsView_Previews: PreviewProvider {
//  static var previews: some View {
//    MemoryControlsView(camera: camera, memoryController: memoryController)
//  }
//}
