//
//  FriendRequestBar.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/14/22.
//

import SwiftUI

struct FriendRequestBar: View {
  
  enum FriendStatus {
    case notFriends
    case requestReceived
    case requestSent
    case friends
  }

  @State var friend : User
  @State var status : FriendStatus
  
  var body: some View {
    NavigationLink(destination: FriendsProfileView(friend: friend)) {
      Image("kwgao")
        .resizable()
        .scaledToFill()
        .frame(width: 40, height: 40)
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
      
      Spacer()
      
      switch status {
      case .notFriends:
        Button (action: {}, label: {
          Image(systemName: "plus")
            .foregroundColor(.black)
            .font(.system(size: 18))
            .padding(.trailing, 6)
        })
      case .requestSent:
        Button (action: {}, label: {
          Image(systemName: "plus")
            .foregroundColor(.black)
            .font(.system(size: 18))
            .padding(.trailing, 6)
        })
      case .requestReceived:
        Button (action: {}, label: {
          Image(systemName: "plus")
            .foregroundColor(.black)
            .font(.system(size: 18))
            .padding(.trailing, 6)
        })
      case .friends:
        Button (action: {}, label: {
          Image(systemName: "plus")
            .foregroundColor(.black)
            .font(.system(size: 18))
            .padding(.trailing, 6)
        })
      }
      
      
    }
  }
}
