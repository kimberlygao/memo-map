//
//  SearchView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//
import SwiftUI
import MapKit

struct SearchView: View {
    @ObservedObject var mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @State private var isEditing = false
    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
        case search
    }
    
    var body: some View {
        HStack {
            
            TextField("Search", text: $searchController.searchQuery, onEditingChanged: { _ in})
            {
//                if searchController.searchQuery != "" {
//                    searchController.isSearching = true
//                }
                searchController.performSearch()
            }
            .onTapGesture {
                self.isEditing = true
            }
            .focused($focusedField, equals: .search)
            .padding(8)
            .padding(.leading, 12)
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
                    searchController.searchQuery = ""
                    searchController.isSearching = false
                    self.focusedField = nil
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .padding(13.5)
                })
            }
        }
        .background(RoundedRectangle(cornerRadius: 50).fill(Color.white))
        .padding(.leading)
        .padding(.trailing)
    }
}

