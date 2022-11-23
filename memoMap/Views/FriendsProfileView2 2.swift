//
//  FriendsProfileView2.swift
//  memoMap
//
//  Created by Chloe Chan on 11/11/22.
//

import SwiftUI

struct FriendsProfileView2: View {
  let username = "chloec"
  let name = "Chloe Chan"
  let places = "40"
  let memories = "180"
  let friends = "13"
  @State var requestPending = true
  
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
      Text("Joined October 2022")
        .foregroundColor(.gray)
      
      
      Spacer()
      
      if requestPending {
        HStack {
          Text("Accept Friend Request?")
          Button(action: {requestPending.toggle()}) {
            Image(systemName: "checkmark")
          }
          Button(action: {requestPending.toggle()}) {
            Image(systemName: "xmark")
          }
        }
        
      }
      else {
        Text("Friend Request Accepted")
          .foregroundColor(.gray)
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
