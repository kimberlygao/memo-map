//
//  LocationRowView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/6/22.
//

import SwiftUI

struct LocationRowView: View {
    var body: some View {
      HStack {
        Image(systemName: "mappin.and.ellipse")
          .foregroundColor(.black)
          .font(.system(size: 30))
        Text("Location Name")
          .foregroundColor(.black)
        Spacer()
      }
      .padding()
      .background(Color("Pastel"))
      .cornerRadius(10)
    }
}

struct LocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRowView()
    }
}
