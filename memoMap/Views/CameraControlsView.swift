//
//  CameraControlsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/6/22.
//

import SwiftUI

struct CameraControlsView: View {
    @StateObject var camera = CameraController()
    var body: some View {
      HStack {
        Button (action: {}, label: {
          Image(systemName: "bolt")
            .foregroundColor(.white)
            .padding()
            .font(.system(size: 30))
        })
        Button (action: camera.takePhoto, label: {
            Circle()
              .stroke(Color.white, lineWidth: 2)
              .frame(width: 65, height: 65)
        })
        Button (action: camera.flipCamera, label: {
          Image(systemName: "arrow.triangle.2.circlepath.camera")
            .foregroundColor(.white)
            .padding()
            .font(.system(size: 30))
        })
      }
      
      
    }
}

