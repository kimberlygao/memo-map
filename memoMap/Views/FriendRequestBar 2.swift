//
//  FriendRequestBar.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/14/22.
//

import SwiftUI

struct FriendRequestBar: View {
  @State var pendingRequest : Bool
  @State var requestSent : Bool = false
  @State var isFriend : Bool
  var body: some View {
    if pendingRequest {
      HStack {
        Text("Accept Friend Request?")
        Button(action: {pendingRequest.toggle()}) {
          Image(systemName: "checkmark")
        }
        Button(action: {pendingRequest.toggle()}) {
          Image(systemName: "xmark")
        }
      }
    }
    
    if isFriend {
      HStack {
        Text("Friends")
      }
    } else {
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
//struct FriendRequestBar_Previews: PreviewProvider {
//    static var previews: some View {
//        FriendRequestBar()
//    }
//}
