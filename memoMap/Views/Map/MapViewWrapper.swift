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
    @ObservedObject var memoryController: MemoryController
    let mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @ObservedObject var userController: UserController
    @ObservedObject var placeController: PlaceController
    @State private var selectedPlace: ImageAnnotation?
    
    @State var selectedPin: ImageAnnotation? = nil
    
    @State var isBottomSheetOpen: Bool = false
    @Binding var ownView: Bool
    @Binding var findUser: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack {
                    //                    LocationSheetView(isOpen: self.$isBottomSheetOpen, memoryController: memoryController)
                    LocationDetailView(isOpen: self.$isBottomSheetOpen, maxHeight: geometry.size.height * 0.8) {
                        //                        Text(String(self.selectedPin?.title ?? "no title")).foregroundColor(Color.black)
                        VStack(alignment: .leading){
                            Group {
                                Text(String(self.selectedPin?.title ?? "Unknown"))
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                Text(String(self.selectedPin?.address ?? "Unknown"))
                                    .foregroundColor(.gray)
                                    .font(.system(size: 16))
                            }
                            Spacer()
                                   .frame(height: 20)
//
//                            })
                            let loc: Place? = placeController.places.first { $0.address == self.selectedPin?.address }
                            if let loc = loc {
                                MemoryGridView(memoryController: memoryController, place: loc, userController: userController)
                            }
                            
                            
                            
//                            MemoryGridView(memoryController: memoryController, place: loc!, userController: userController)
                            
//                            Spacer()
//                                .frame(height: 20)
                            
//                            MemoryGridView(memoryController: memoryController)
                        }
                        .padding(20)
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
                
                
                MapView(mapViewController: mapViewController, searchController: searchController, memoryController: memoryController, annotations: searchController.annotations, selectedPin: self.$selectedPin,
                        isBottomSheetOpen: self.$isBottomSheetOpen, ownView: self.$ownView, findUser: self.$findUser
                )
                .navigationBarTitleDisplayMode(.inline)
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
        }
        //            .sheet(item: $selectedPlace) { place in
        //                    Text(place.title!)
        //                }
    }
}
//}
