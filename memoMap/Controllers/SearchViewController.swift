//
//  SearchViewController.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/11/10.
//

import Foundation
import UIKit
import MapKit

protocol SearchViewControllerDelegate: AnyObject {
    func getSearchRegion(_ vc: SearchViewController) -> MKCoordinateRegion 
}

class SearchViewController: UIViewController, ObservableObject {
//    private let label = UILa
    
    @Published var searchAnnotations : [MKPointAnnotation] = []
    weak var delegate: SearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func performSearch(search: String) {
        print("searching")
//        self.mapView.removeAnnotations(mapView.annotations)
        // reset search annotations
        self.searchAnnotations = []
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
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.searchAnnotations.append(annotation)
            })
//            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
}
