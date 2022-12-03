//
//  CameraControlsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/6/22.
//

import SwiftUI

struct CameraControlsView: View {
  @StateObject var camera : CameraController
    var body: some View {
//      GeometryReader { geometry in
        HStack {
          var flash = camera.flashMode
          Button (action: {
            camera.toggleFlash()
            flash = camera.flashMode
          }, label: {
            if flash == .on {
              Image(systemName: "bolt.fill")
                .foregroundColor(.white)
                .padding()
                .font(.system(size: 36))
            } else {
              Image(systemName: "bolt")
                .foregroundColor(.white)
                .padding()
                .font(.system(size:36))
            }
          })
          .padding(.leading, 15)
          Spacer()
          .frame(width: 30)
          Button (action: camera.takePhoto, label: {
            Circle()
              .stroke(Color.white, lineWidth: 4)
              .frame(width: 70, height: 70)
          })
          Spacer()
            .frame(width: 30)
          Button (action: camera.flipCamera, label: {
            Image(systemName: "arrow.triangle.2.circlepath.camera")
              .foregroundColor(.white)
              .padding()
              .font(.system(size: 36))
          })
          
        }
        .padding(.bottom, 50)
//        .frame(width: geometry.size.width)
//        .background(.black)
//        .opacity(0.7)
        
//      }
      
    }
}

