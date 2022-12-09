//
//  SearchController.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import Foundation
import UIKit
import MapKit

protocol SearchControllerDelegate: AnyObject {
    func getSearchRegion(_ vc: SearchController) -> MKCoordinateRegion
}

class SearchController: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var annotations = [ImageAnnotation]()
    @Published var searchQuery = ""
    @Published var isSearching = false
    
    weak var delegate: SearchControllerDelegate?

    var cancellable: Any?
    
    override init() {
        super.init()
        cancellable = $searchQuery.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: {[weak self] (query) in
                self?.performSearch()
            })
    }
    
    func performSearch() {
        if self.searchQuery == "" {
            self.annotations = []
        }
        var annotationsResult = [ImageAnnotation]()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchQuery
        request.region = delegate?.getSearchRegion(self) ?? MKCoordinateRegion()
        let localSearch = MKLocalSearch(request: request)
        
        localSearch.start{
            (resp, err) in
            if let err = err {
                print("Failed local search", err)
                return
            }
            //success
            resp?.mapItems.forEach({
                (mapItem) in print(mapItem.name ?? "")
                let LA = LocationAnnotation(title: mapItem.name ?? "", subtitle: "", coordinate: mapItem.placemark.coordinate)
                let annotation = ImageAnnotation(id: UUID().uuidString, locAnnotation: LA, image: UIImage(named: "blank") ?? UIImage(), address: "")
                annotation.isMemory = false
                annotation.image = UIImage(named: "blank")
                annotationsResult.append(annotation)
            })
            self.annotations = annotationsResult
            self.isSearching = true
        }
//        print("all results:", self.annotations)
    }
}
