//
//  LocationListView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import SwiftUI
import MapKit

struct LocationListView: View {
    let locations: [Location]
    
    var onTap: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.blue)
                .gesture(TapGesture().onEnded(self.onTap)
            )
            List {
                ForEach(self.locations, id: \.id) {location in
                    VStack(alignment: .leading) {
                        Text(location.name!)
                            .fontWeight(.bold)
                        Text(location.name!)
                    }
                }
            }
        }.cornerRadius(10)
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView(locations: [Location()], onTap: {})
    }
}
