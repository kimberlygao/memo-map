//
//  ProfileView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/14/22.
//

import SwiftUI

struct ProfileView: View {
  var user : User
  var isFriendProfile : Bool
  
  var body: some View {
    VStack {
      if !isFriendProfile {
        Text("Profile")
      }
      
      
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
        Text(user.id ?? "no username")
          .font(.headline)
        Text(user.name)
          .foregroundColor(.gray)
      }
      
      Spacer()
        .frame(height: 30)
      
      HStack {
        Spacer()
        VStack {
          Text("places")
          Text("30")
        }.padding()
        
        Spacer()
        
        VStack {
          Text("memories")
          Text("40")
        }.padding()
        
        Spacer()
        
        VStack {
          Text("friends")
          Text("2")
        }.padding()
        
        Spacer()
      }.background(Color.blue)
        .padding()
      Text("Joined September 2022")
        .foregroundColor(.gray)
      
      Spacer()
    }
    
  }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
