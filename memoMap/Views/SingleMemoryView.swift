//
//  SingleMemoryView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/29/22.
//

import SwiftUI

struct SingleMemoryView: View {
  var memoryController : MemoryController
  @State var bigImage : UIImage
  @State var smallImage : UIImage
  var memory : Memory
  let dateFormatter = DateFormatter()
  @State var friendMemory : Bool
  @State var showLocation : Bool
  
  var body: some View {
    ZStack {
      GeometryReader { geo in
        VStack(spacing: 0) {
          
          Spacer()
          HStack { //user info
            if friendMemory {
              Image(uiImage: memoryController.getPfpFromMemory(mem: memory))
                .resizable()
                .scaledToFill()
                .frame(width: 35, height: 35)
                .clipShape(Circle())
                .padding(.trailing, 4)
            }
            VStack {
              if friendMemory {
                Text(memory.username)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundColor(.black)
                  .font(.system(size: 16))
              } else {
                Text("")
                  .font(.system(size: 16))
              }
              
              if showLocation {
                Text(memoryController.placeToStr(placeID: memory.location))
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundColor(.gray)
                  .font(.system(size: 14))
              }
              
              if !friendMemory && !showLocation {
                Text("")
                  .font(.system(size: 14))
              }
              
              Text(memoryController.timeToStr(timestamp: memory.timestamp))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            }
          }
          .padding(0)
          .frame(width: geo.size.width - 40)
          
          HStack { // memory pictures
            ZStack {
              Image(uiImage: bigImage)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width - 40, height: geo.size.width / 3 * 4)
                .cornerRadius(15)
              VStack{
                HStack {
                  Button(action: {
                    let temp = bigImage
                    bigImage = smallImage
                    smallImage = temp
                  }) {
                    Image(uiImage: smallImage)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 150, height: 200)
                      .overlay(
                                  RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 3)
                              )
                      .cornerRadius(10)
                  }
                  Spacer()
                }
                Spacer()
              }
              .padding(.leading, 40)
              .padding(.top, 60)
            }
            
          }
          
          HStack { // caption
            VStack (alignment: .leading) {
              Text(memory.caption)
                .font(.system(size: 16))
            }
            .padding(6)
            Spacer()
          }
          .padding(4)
          .frame(width: geo.size.width - 40)
          .background(Color("pastel"))
          .cornerRadius(10)
          .multilineTextAlignment(.leading)
          
          Spacer()
        }
        
        Spacer()
      }
      
    }
  }
}
