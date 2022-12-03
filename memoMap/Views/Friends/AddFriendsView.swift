//
//  AddFriendsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/10/22.
//

import SwiftUI

struct AddFriendsView: View {
  private enum Field: Int, CaseIterable {
    case search
  }
  
  @State var searchText = ""
  @State private var isEditing = false
  @FocusState private var focusedField: Field?
  @ObservedObject var userController : UserController
  
  var body: some View {
    
    VStack {
      
      HStack {
        
        TextField("Search", text: $searchText)
          .padding(.leading, 16)
          .onTapGesture {
            self.isEditing = true
          }
          .focused($focusedField, equals: .search)
        Spacer()
        if !isEditing {
          Button(action: {}, label: {
            Image(systemName: "magnifyingglass")
              .font(.system(size: 16))
              .foregroundColor(.black)
              .padding(12)
          })
        } else {
          Button(action: {
            self.isEditing.toggle()
            self.searchText = ""
            self.focusedField = nil
          }, label: {
            Image(systemName: "xmark")
              .font(.system(size: 16))
              .foregroundColor(.black)
              .padding(13.5)
          })
        }
        
      }
      .background(RoundedRectangle(cornerRadius: 50).stroke(.black))
      
      Spacer()
        .frame(height: 40)
      
      VStack {
        Text("Requests")
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .topLeading)
        
        ForEach (userController.getReceivedRequests(user: userController.currentUser).filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { person in
          FriendRequestBar(friend: person, userController: userController)
        }
        
        Spacer()
          .frame(height: 20)
        
        Text("Friends")
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .topLeading)
        
        ForEach(userController.getFriends(user: userController.currentUser).filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { person in
          FriendRequestBar(friend: person, userController: userController)
        }
      }
      
      if isEditing {
        Spacer()
          .frame(height: 20)
        
        Text("Suggestions")
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .topLeading)
        ForEach(userController.users.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { person in
          if !["friends", "requestReceived"].contains(userController.getFriendStatus(currUser: userController.currentUser, otherUser: person)) {
            if person.name != userController.currentUser.name {
              FriendRequestBar(friend: person, userController: userController)
            }
           
          }
        }
      }
      
      Spacer()
    }
    .padding()
  }
}
