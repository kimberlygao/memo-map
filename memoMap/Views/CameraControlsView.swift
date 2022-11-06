//
//  CameraControlsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/6/22.
//

import SwiftUI

struct CameraControlsView: View {
  @State private var caption: String = ""
    var body: some View {
      VStack (alignment: .leading) {
        HStack {
          Image(systemName: "mappin.and.ellipse")
            .foregroundColor(.black)
            .font(.system(size: 30))
          Text("Tepper School of Business")
        }
        
        TextField("Add a caption", text: $caption)
          .padding()
        
        HStack {
          Spacer()
          Image(systemName: "paperplane")
            .foregroundColor(.black)
            .font(.system(size: 30))
            .rotationEffect(Angle(degrees: 45))
            .padding(.leading)
        }
        
      }
      .padding()
      .background(Color.white)
      
      
    }
}

struct CameraControlsView_Previews: PreviewProvider {
    static var previews: some View {
        CameraControlsView()
    }
}
