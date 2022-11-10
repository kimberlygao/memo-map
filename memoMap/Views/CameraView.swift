//
//  CameraView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
  @StateObject var camera : CameraController
  @ObservedObject var memoryController : MemoryController
  
  var body: some View {
    ZStack {
      
      CameraPreview(camera: camera)
        .ignoresSafeArea(.all, edges: .all)

      if camera.isTaken {
        GeometryReader { geo in
          Image(uiImage: camera.images[1])
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width + 20, height: geo.size.width / 3 * 4)
            .ignoresSafeArea(.all, edges: .all)
        }
      }
      
      if camera.image1Done {
        VStack{
          HStack {
            Image(uiImage: camera.images[0])
              .resizable()
              .scaledToFill()
              .frame(width: 150, height: 200)
              .cornerRadius(20)
              
            Spacer()
          }
          Spacer()
        }
        .padding(20)
      }
        
      VStack {
        // after photo is taken -> add controls
        if camera.isTaken {
          HStack {
            Spacer()
            Button(action: {if camera.isTaken{
              camera.reTake()} else {}}, label: {
                Image(systemName: "xmark")
                  .foregroundColor(.white)
                  .padding()
                  .font(.system(size: 30))
              })
            .padding(.trailing, 10)
          }
        }
        Spacer()
        HStack {
          if camera.isTaken {
            MemoryControlsView(camera: camera, memoryController: memoryController)
              .background(Color.white)
              .padding(.bottom)
              .cornerRadius(30)
          } else {
            CameraControlsView(camera: camera)
          }
        }
        .frame(height: 75)
      }
    }
  }
}

struct CameraPreview: UIViewRepresentable {
  var camera : CameraController
  
  func updateUIView(_ uiView: UIView, context: Context) {
    
  }
  
  func makeUIView(context: Context) ->  UIView {
    let view = UIView(frame: UIScreen.main.bounds)
    
    camera.setUpPreviewLayer()
    view.layer.addSublayer(camera.preview)
    
    return view
  }
}
