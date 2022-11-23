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
    TextField("Search", text: $search, onEditingChanged: { _ in})
    {
      print(self.search)
      if self.search == "" {
        mapViewController.addMapAnnotations()
      } else {
        mapViewController.performSearch(search: self.search)
      }
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

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
