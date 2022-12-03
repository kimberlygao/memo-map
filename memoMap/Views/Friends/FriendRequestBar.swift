//
//  FriendRequestBar.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/14/22.
//

import SwiftUI

struct FriendRequestBar: View {
  
  @State var friend : User
  @ObservedObject var userController : UserController
  @ObservedObject var memoryController : MemoryController
  
  var body: some View {
    HStack {
      NavigationLink(destination: ProfileView(user: friend, userController: userController, memoryController: memoryController)) {
        Image(uiImage: memoryController.getPfpUser(user: friend))
          .resizable()
          .scaledToFill()
          .frame(width: 35, height: 35)
          .clipShape(Circle())
          .padding(.trailing, 4)
        VStack {
          Text(friend.id ?? "   ")
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.black)
          Text(friend.name)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.gray)
            .font(.system(size: 14))
        }
      }
      
      Spacer()
      
      let status = userController.getFriendStatus(currUser: userController.currentUser, otherUser: friend)
      if status == "noStatus" {
        Button (action: {
          userController.sendFriendRequest(currUser: userController.currentUser, receiver: friend)
        }, label: {
          Image(systemName: "plus")
            .foregroundColor(.black)
            .font(.system(size: 18))
            .padding(.trailing, 6)
        })
      } else if status == "requestSent" {
        Text("Added")
          .foregroundColor(.gray)
          .font(.system(size: 14))
          .padding(.trailing, 6)
      } else if status == "requestReceived" {
        Button (action: {userController.processFriendRequest(currUser: userController.currentUser, requester: friend, clicked: "deny")}, label: {
          Image(systemName: "xmark")
            .foregroundColor(.black)
            .font(.system(size: 16))
        })
        Button (action: {userController.processFriendRequest(currUser: userController.currentUser, requester: friend, clicked: "accept")}, label: {
          Image(systemName: "checkmark")
            .foregroundColor(.black)
            .font(.system(size: 16))
        })
      }
    }
    .padding(8)
    .padding(.leading, 6)
    .padding(.trailing, 6)
    .background(Color("light"))
    .cornerRadius(10)
  }
}
