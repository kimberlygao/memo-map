//
//  MemoryControlsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/6/22.
//

import SwiftUI
import MapKit

struct MemoryControlsView: View {
  @State private var selectedLocation = "Select Location"
  @State private var caption: String = ""
  @StateObject var camera : CameraController
  @ObservedObject var memoryController : MemoryController
  @StateObject var mapViewController : MapViewController
  @Environment(\.presentationMode) var presentationMode
  
  
  var body: some View {
    VStack (alignment: .leading) {
      HStack {
        Image(systemName: "mappin.and.ellipse")
          .foregroundColor(.black)
          .font(.system(size: 24))
        Menu(selectedLocation) {
          ForEach (mapViewController.getNearbyLocations(using: MKLocalSearch.Request()), id: \.self) { name in
            Button(name, action: {
              selectedLocation = name
            })
            
          }
        }.underline()
          .foregroundColor(.black)
          .font(.system(size: 20, weight: .medium))
      }
      
      TextField("Add a caption...", text: $caption)
        .font(.system(size: 18))
        .padding(.top, 4)
      
      Spacer()
      
      HStack {
        Spacer()
        Button(action: {
          memoryController.saveMemory(caption: caption, front: camera.images[0], back: camera.images[1], location: "1")
          camera.reTake()
          presentationMode.wrappedValue.dismiss()
        },
               label: {
          Image(systemName: "paperplane")
            .foregroundColor(.black)
            .font(.system(size: 24))
            .rotationEffect(Angle(degrees: 45))
            .padding(.leading)
        })
      }
      .padding(.bottom, 10)
      
      Spacer()
      
    }
    .padding()
    .padding(.bottom, 20)
    .padding(.top, 10)
    .frame(height: 350)
  }
}

//
//struct MemoryControlsView_Previews: PreviewProvider {
//  static var previews: some View {
//    MemoryControlsView(camera: camera, memoryController: memoryController)
//  }
//}
