//
//  AddFriendsView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/10/22.
//

import SwiftUI

struct AddFriendsView: View {
  let names = ["kwgao", "chloec", "fionac"]
  @State private var searchText = ""
  @State private var friendAdded = false
  
  var body: some View {
      List {
        ForEach(searchResults, id: \.self) { name in
          ZStack {
            NavigationLink(destination: Text(name)) {
              EmptyView()
            }
            .opacity(0.0)

            HStack {
              Image(systemName: "person.circle")
              Text(name)
              Spacer()
              Button (action: {}, label: {
                if !friendAdded {
                  Image(systemName: "plus")
                    .foregroundColor(.black)
                } else {
                  Image(systemName: "checkmark")
                    .foregroundColor(.black)
                }
                    
              })
            }
          }
        }
      }
      .searchable(text: $searchText)
      .navigationTitle("Add Friends")
  }
  
  var searchResults: [String] {
    if searchText.isEmpty {
      return names
    } else {
      return names.filter { $0.contains(searchText) }
    }
  }
}

struct AddFriendsView_Previews: PreviewProvider {
  static var previews: some View {
    AddFriendsView()
  }
}
