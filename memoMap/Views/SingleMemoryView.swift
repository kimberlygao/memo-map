//
//  SingleMemoryView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/29/22.
//

import SwiftUI

struct SingleMemoryView: View {
  @ObservedObject var memoryController : MemoryController
  @State var bigImage : UIImage
  @State var smallImage : UIImage
  
  var body: some View {
      ZStack {
        GeometryReader { geo in
          VStack {
            HStack {
              Spacer()
              Image("kwgao")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width - 40, height: geo.size.width / 3 * 4)
                .cornerRadius(20)
              Spacer()
            }
            HStack {
              VStack (alignment: .leading) {
                Text("date")
                Text("caption")
              }
              .padding(10)
              Spacer()
            }
            .frame(width: geo.size.width - 40)
            .background(.blue)
            .cornerRadius(10)
            .padding(10)
            .multilineTextAlignment(.leading)
          }
        }
        VStack{
          HStack {
            Button(action: {
              var temp = bigImage
              bigImage = smallImage
              smallImage = temp
            }) {
              Image("kwgao")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 200)
                .cornerRadius(20)
            }
            Spacer()
          }
          Spacer()
        }
        .padding(.leading, 40)
        .padding(.top, 20)
      }
  }
}
