//
//  MapViewWrapper.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/17.
//

import Foundation
import SwiftUI
import MapKit
import ComposableArchitecture


struct MapViewWrapper: View {
    @ObservedObject var mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @State private var selectedPlace: ImageAnnotation?
    
    @State var selectedPin: ImageAnnotation? = nil
    @State var isBottomSheetOpen: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack {
                    Spacer()
                    LocationDetailView(isOpen: self.$isBottomSheetOpen, maxHeight: geometry.size.height * 0.3) {
                        Text(String(self.selectedPin?.title ?? "no title")).foregroundColor(Color.black)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
                
                
                MapView(mapViewController: mapViewController, searchController: searchController, annotations: searchController.annotations, currMemories: mapViewController.currMemories, selectedPin: self.$selectedPin,
                        isBottomSheetOpen: self.$isBottomSheetOpen
                        )
                        .searchable(
                          text: $searchController.searchQuery)
                                    //                                placement: <#T##SearchFieldPlacement#>)
                                    //                            prompt: <#T##Text?#>,
                                    //                            suggestions:
                        .navigationBarTitleDisplayMode(.inline)
                        .edgesIgnoringSafeArea(.all)
                    //            SearchView(mapViewController: mapViewController, searchController: searchController)
                    //            if searchController.searchQuery != "" {
                    ////                print("search query empty true")
                    //                SearchView(mapViewController: mapViewController, searchController: searchController)
                    //            }
                }.sheet(item: $selectedPlace) { place in
                    Text(place.title!)
                }
        }
    }
}
