//
//  FriendsProfileView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/10/22.
//

import SwiftUI

struct FriendsProfileView: View {
  let username = "kwgao"
  let name = "Kimberly Gao"
  let places = "30"
  let memories = "100"
  let friends = "12"
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
        Text(username)
          .font(.headline)
        Text(name)
          .foregroundColor(.gray)
      }
      
      Spacer()
        .frame(height: 30)
      
      HStack {
        Spacer()
        VStack {
          Text("places")
          Text(places)
        }.padding()
        
        Spacer()
        
        VStack {
          Text("memories")
          Text(memories)
        }.padding()
        
        Spacer()
        
        VStack {
          Text("friends")
          Text(friends)
        }.padding()
        
        Spacer()
      }.background(Color.blue)
        .padding()
      Text("Joined September 2022")
        .foregroundColor(.gray)
      
      
      
      Spacer()
      Button(action: {requestSent.toggle()}) {
        if !requestSent {
          Text("Send Friend Request")
        }
        else {
          Text("Friend Request Sent")
            .foregroundColor(.gray)
        }
      }
    }
    
  }
}
//
//struct FriendsProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    FriendsProfileView(requestSent: requestSent)
//  }
//}
