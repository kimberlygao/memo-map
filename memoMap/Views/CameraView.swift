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
