//
//  CameraView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
  //  let cameraController = CameraController()
  @StateObject var camera = CameraController()
  var body: some View {
    ZStack {
      
      CameraPreview(camera: camera)
        .ignoresSafeArea(.all, edges: .all)
      
//      if camera.isTaken {
//        Image(uiImage: camera.image2).frame(width: 100, height: 100)
//      }
      
      if camera.image1Done {
        Image(uiImage: camera.image1).frame(width: 50, height: 50, alignment: .topLeading)
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
            MemoryControlsView()
              .background(Color.white)
              .padding(.bottom)
              .cornerRadius(20)
          } else {
            CameraControlsView(camera: camera)
          }
        }
        .frame(height: 75)
      }
    }
    .onAppear(perform: {
      camera.check()
    })
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
