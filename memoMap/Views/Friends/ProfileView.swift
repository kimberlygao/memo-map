//
//  ProfileView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/14/22.
//

import SwiftUI

struct ProfileView: View {
  var user : User
  @ObservedObject var userController : UserController
  
  var body: some View {
    VStack {
      Spacer()
        .frame(height: 30)
      
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
      
      let stats = userController.getStats(user: user)
      

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
        }
        .padding(8)
        .background(Color("light"))
        .cornerRadius(10)

      
      
      
      Text("Joined September 2022")
        .foregroundColor(.gray)
        .padding(8)
      
      Spacer()
    }
    .padding(20)
    
  }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
