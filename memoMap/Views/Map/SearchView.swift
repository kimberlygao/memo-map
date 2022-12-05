//
//  SearchView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import SwiftUI
import MapKit

struct SearchView: View {
    let mapViewController: MapViewController
    //    @ObservedObject var mapViewController: MapViewController
    //    @ObservedObject var mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @State private var isEditing = false
    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
        case search
    }
    
    //    @State var search: String = ""
    //    @State private var selectedMemory: ImageAnnotation?
    
    var body: some View {
        //         ZStack (alignment: .top) {
        //             MapView(mapViewController: mapViewController, searchController: searchController, annotations: searchController.annotations, currMemories: mapViewController.currMemories).edgesIgnoringSafeArea(.all)
        HStack {
            
            TextField("Search", text: $searchController.searchQuery, onEditingChanged: { _ in})
            {
                if searchController.searchQuery != "" {
                    searchController.isSearching = true
                }
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
    //         }
    //         .sheet(item: $selectedMemory) { place in
    //             Text(place.name)
    //         }
    //         TextField("Search", text: $search, onEditingChanged: { _ in})
    //                   {
    //                       print(self.search)
    //                       searchViewController.performSearch(search: self.search)
    //                   }
    //                 .textFieldStyle(RoundedBorderTextFieldStyle())
    //                 // Text alignment.
    //    .multilineTextAlignment(.leading)
    //    // Text/placeholder font.
    //    .font(.title.weight(.thin))
    //    .frame(width: 380, height: 60, alignment: .center)
    //    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
