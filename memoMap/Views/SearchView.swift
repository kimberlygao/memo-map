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
//    @ObservedObject var mapViewController: MapViewController
//    @ObservedObject var mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @State var search: String = ""
    
     var body: some View {
         ZStack(alignment: .top) {
             MapView(mapViewController: mapViewController, searchController: searchController, annotations: searchController.annotations).edgesIgnoringSafeArea(.all)
             HStack {
                 TextField("Search", text: $searchController.searchQuery)
                    {
                        print(self.search)
//                        searchController.performSearch(search: self.search)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    // Text alignment.
                    .multilineTextAlignment(.leading)
                    // Text/placeholder font.
                    .font(.title.weight(.thin))
                    .frame(width: 380, height: 60, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
             }
         }
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
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
