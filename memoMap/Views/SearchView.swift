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
  @State var search: String = ""
  
  var body: some View {
      HStack {

        TextField("Search", text: $search, onEditingChanged: { _ in})
        {
          if self.search == "" {
            mapViewController.addMapAnnotations()
          } else {
            mapViewController.performSearch(search: self.search)
          }
        }
        .padding(8)
        .padding(.leading, 12)
        Spacer()
        Image(systemName: "magnifyingglass")
          .padding()
      }
      .background(RoundedRectangle(cornerRadius: 50).fill(Color.white))
      .padding(.leading)
      .padding(.trailing)
  }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
