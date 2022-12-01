//
//  FriendsProfileView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/10/22.
//

import SwiftUI

struct FriendsProfileView: View {
  var friend : User
  var stats : [String]
  @State var requestSent = false
  
  var body: some View {
    VStack {
      Text("Profile")
      
      Spacer()
        .frame(height: 50)
      
      Image("kwgao")
        .resizable()
        .scaledToFill()
        .frame(width: 150, height: 150)
        .clipShape(Circle())
      Spacer()
        .frame(height: 30)
      VStack {
        Text(friend.id ?? "")
          .font(.headline)
        Text(friend.name)
          .foregroundColor(.gray)
      }
      
      Spacer()
        .frame(height: 30)
      
      HStack {
        Spacer()
        VStack {
          Text("places")
          Text(stats[0])
        }.padding()
        
        Spacer()
        
        VStack {
          Text("memories")
          Text(stats[1])
        }.padding()
        
        Spacer()
        
        VStack {
          Text("friends")
          Text(stats[2])
        }.padding()
        
        Spacer()
      }.background(Color.blue)
        .padding()
      Text("Joined September 2022")
        .foregroundColor(.gray)
      
      
      
      Spacer()
//      Button(action: {requestSent.toggle()}) {
//        if !requestSent {
//          Text("Send Friend Request")
//        }
//        else {
//          Text("Friend Request Sent")
//            .foregroundColor(.gray)
//        }
//      }
    }
    
  }
}
//
//struct FriendsProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    FriendsProfileView(requestSent: requestSent)
//  }
//}
