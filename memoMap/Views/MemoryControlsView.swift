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
  let viewController: ViewController = ViewController()
  var body: some View {
    VStack (alignment: .leading) {
      HStack {
        Image(systemName: "mappin.and.ellipse")
          .foregroundColor(.black)
          .font(.system(size: 30))
        Button(action: {}) {
          Text("Location")
        }
      }
      
      TextField("Add a caption...", text: $caption)
      
      Spacer()
      
      HStack {
        Spacer()
        NavigationLink(destination: MapView(viewController: viewController), label: {
          Button(action: {}, label: {
            Image(systemName: "paperplane")
              .foregroundColor(.black)
              .font(.system(size: 30))
              .rotationEffect(Angle(degrees: 45))
              .padding(.leading)
          })
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


struct MemoryControlsView_Previews: PreviewProvider {
  static var previews: some View {
    MemoryControlsView()
  }
}
