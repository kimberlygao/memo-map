//
//  PromptMapWrapper.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/12/1.
//

import SwiftUI

struct PromptMapWrapper: View {
    @State private var blurredSheet = true
    @State private var showingSheet = true
    @ObservedObject var memoryController: MemoryController
    let mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @State private var selectedPlace: ImageAnnotation?
    @State var isBottomSheetOpen: Bool = false
    @State var selectedPin: ImageAnnotation? = nil
    
    var body: some View {
      ZStack {
        MapView(mapViewController: mapViewController, searchController: searchController, annotations: searchController.annotations, currMemories: mapViewController.currMemories, selectedPin: self.$selectedPin,
                isBottomSheetOpen: self.$isBottomSheetOpen
                )
        .edgesIgnoringSafeArea(.all)
      }
      .background(Color.pink)
    }
}

//struct PromptMapWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        PromptMapWrapper()
//    }
//}
