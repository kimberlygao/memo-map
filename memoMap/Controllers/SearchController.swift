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
    //    private let label = UILa
    
    @Published var annotations = [LocationAnnotation]()
    @Published var searchQuery = ""
    
    weak var delegate: SearchControllerDelegate?

    var cancellable: Any?
    
    override init() {
        super.init()
        cancellable = $searchQuery.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: {[weak self] (query) in
                self?.performSearch(search: query)
            })
    }
    
    private func performSearch(search: String) {
        print("searching")
        //        self.mapView.removeAnnotations(mapView.annotations)
        // reset search annotations
        var annotationsResult = [LocationAnnotation]()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
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
                let annotation = LocationAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                annotationsResult.append(annotation)
            })
            self.annotations = annotationsResult
            //            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
        print("all results:", self.annotations)
    }
}
