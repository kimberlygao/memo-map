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
      
      if isEditing {
        Text("Results")
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .topLeading)
          ForEach(userController.users.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { item in
            ZStack {
              HStack {
                NavigationLink(destination: FriendsProfileView(friend: item)) {
                  Image("kwgao")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding(.trailing, 4)
                  VStack {
                    Text(item.id ?? "   ")
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .foregroundColor(.black)
                    Text(item.name)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .foregroundColor(.gray)
                      .font(.system(size: 14))
                  }
                }
                
                Spacer()
                Button (action: {}, label: {
                  Image(systemName: "plus")
                    .foregroundColor(.black)
                    .font(.system(size: 18))
                    .padding(.trailing, 6)
                })
              }
              .padding(8)
              .background(.blue)
              .cornerRadius(10)
            }
            Spacer()
              .frame(height: 8)
        }
      } else {
        VStack {
          Text("Requests")
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .topLeading)
          
          ForEach (userController.getFriends(user: userController.currentUser), id: \.self) { person in
            HStack {
              Image("kwgao")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.trailing, 4)
              VStack {
                Text(person.id ?? "   ")
                  .frame(maxWidth: .infinity, alignment: .leading)
                Text(person.name)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .foregroundColor(.gray)
              }
              
              Spacer()
              Button (action: {}, label: {
                Image(systemName: "xmark")
                  .foregroundColor(.black)
                  .font(.system(size: 20))
              })
              Button (action: {}, label: {
                Image(systemName: "checkmark")
                  .foregroundColor(.black)
                  .font(.system(size: 20))
              })
            }
            .padding(8)
            .background(.blue)
            .cornerRadius(10)
            
          }
        }
        
      }
      
      
      Spacer()
    }
    .padding()
  }
}
