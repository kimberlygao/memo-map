//
//  AddFriendsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/10/22.
//

import SwiftUI

struct AddFriendsView: View {
  let names = ["kwgao"]
  @State private var searchText = ""
  @Binding var showingFriends: Bool
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Button (action: {showingFriends.toggle()}) {
          Image(systemName: "chevron.right")
        }
        .padding()
      }
    
      List {
        ForEach(searchResults, id: \.self) { name in
          ZStack {
            NavigationLink(destination: FriendsProfileView())
            {
              EmptyView()
            }
            .opacity(0.0)
            
            HStack {
              Image(systemName: "person.circle")
              Text(name)
              Spacer()
              //              Button (action: {requestSent.toggle()}, label: {
              //                if !requestSent {
              //                  Image(systemName: "plus")
              //                    .foregroundColor(.black)
              //                } else {
              //                  Image(systemName: "checkmark")
              //                    .foregroundColor(.black)
              //                }
              //
              //              })
            }
          }
        }
      }
    }
    .searchable(text: $searchText)
    .navigationTitle("Add Friends")
    .transition(.move(edge: .leading))
    .background(.white)
  }
  
  var searchResults: [String] {
    if searchText.isEmpty {
      return names
    } else {
      return names.filter { $0.contains(searchText) }
    }
  }
}

//struct AddFriendsView_Previews: PreviewProvider {
//  static var previews: some View {
//    AddFriendsView()
//  }
//}
