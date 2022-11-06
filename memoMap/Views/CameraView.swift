//
//  CameraView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
//  let cameraController : CameraController
  @StateObject var camera = Camera()
  var body: some View {
    ZStack {
      CameraPreview(camera: camera)
        .ignoresSafeArea(.all, edges: .all)
      
      VStack {
        if camera.isTaken {
          HStack {
            Spacer()
            Button(action: {camera.reTake()}, label: {
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
            Button(action: {if !camera.isSaved{camera.savePhoto()}}, label: {
              Text("Save")
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.white)
                .clipShape(Capsule())
            })
            .padding(.leading)
            
            Spacer()
            
          } else {
            Button (action: camera.takePhoto, label: {
              ZStack {
                Circle()
                  .stroke(Color.white, lineWidth: 2)
                  .frame(width: 65, height: 65)
               
              }
            })
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

//struct CameraView_Previews: PreviewProvider {
//  static var previews: some View {
//      CameraView(cameraController: CameraController)
//  }
//}


struct CameraPreview: UIViewRepresentable {
  func updateUIView(_ uiView: UIView, context: Context) {
  
  }
  
  @ObservedObject var camera : Camera
  
  func makeUIView(context: Context) ->  UIView {
    let view = UIView(frame: UIScreen.main.bounds)
    
    camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
    camera.preview.frame = view.frame
    
    camera.preview.videoGravity = .resizeAspectFill
    view.layer.addSublayer(camera.preview)
    
    camera.session.startRunning()
    
    return view
  }
}
