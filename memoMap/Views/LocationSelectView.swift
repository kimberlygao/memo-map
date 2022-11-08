//
//  LocationSelectView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/8/22.
//

import SwiftUI

struct LocationSelectView: View {
  var locations = ["one", "two", "three"]
  var body: some View {
    Text("Location")
    //      List {
    //        ForEach(locations) { loc in
    //        LocationRowView()
    //        }
    //      }.navigationBarTitle("Library")
    //    }
  }
}

struct LocationSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSelectView()
    }
}
