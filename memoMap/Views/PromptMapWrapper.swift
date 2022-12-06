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
        ZStack(alignment: .top) {
            //            VStack {
            //                LocationSheetView(isOpen: self.$showingSheet, memoryController: memoryController)
            //            }
            //            .edgesIgnoringSafeArea(.all)
            //            .zIndex(1)
            
            
//            MapView(mapViewController: mapViewController, searchController: searchController, memoryController: memoryController, annotations: searchController.annotations, currMemories: mapViewController.currMemories, selectedPin: self.$selectedPin,
//                    isBottomSheetOpen: self.$isBottomSheetOpen, ownView: <#T##Binding<Bool>#>
//            )
//            .navigationBarTitleDisplayMode(.inline)
//            .edgesIgnoringSafeArea(.all)
            Spacer()
        }.sheet(isPresented: Binding<Bool>(get: { !blurredSheet },
                                           set: { blurredSheet = !$0 })) {
            NavigationView {
//                MemoryGridView(memoryController: memoryController)
                LocationSheetView(memoryController: memoryController)
                
                
            }.presentationDetents([.medium, .large])
        }
    }
}

//struct PromptMapWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        PromptMapWrapper()
//    }
//}
