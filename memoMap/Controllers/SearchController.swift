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
    
    @Published var annotations = [ImageAnnotation]()
    @Published var searchQuery = ""
    
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
        print("searching")
        //        self.mapView.removeAnnotations(mapView.annotations)
        // reset search annotations
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
              let annotation = ImageAnnotation(id: UUID().uuidString, locAnnotation: LA, image: UIImage(named: "blank") ?? UIImage())
                annotation.image = UIImage(named: "blank")
//                let annotation = ImageAnnotation(locAnnotation: loc)
//                annotation.url = "https://lh3.googleusercontent.com/p/AF1QipP5UAJ9UxBIImLai1GyUC-pqgojujTOA3wbG8zy=s1360-w1360-h1020"
//                let annotation = LocationAnnotation(title: mapItem.name ?? "", subtitle: "", coordinate: mapItem.placemark.coordinate)
//                annotation.coordinate = mapItem.placemark.coordinate
//                annotation.title = mapItem.name
                
                annotationsResult.append(annotation)
            })
            self.annotations = annotationsResult
            //            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
        
//        for annotation in self.annotations {
//            print("loaded url:", annotation.url)
//            DispatchQueue.main.async {
//                let request = NSMutableURLRequest(url: URL(string: annotation.url)!)
//                request.httpMethod = "GET"
//                let session = URLSession(configuration: URLSessionConfiguration.default)
//                let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
//                    if error == nil {
//                        let loc = LocationAnnotation(title: annotation.title ?? "", subtitle: annotation.subtitle ?? "", coordinate: annotation.coordinate)
//                        let annotation = ImageAnnotation(locAnnotation: loc)
////                        annotation.coordinate = memory.coordinate
//                        annotation.image = UIImage(data: data!, scale: UIScreen.main.scale)
////                        annotation.title = memory.title
////                        annotation.subtitle = memory.subtitle
////                        let locAnnotation = LocationAnnotation(title: memory.title, subtitle: memory.subtitle, coordinate: )
//                        
////                        let imageAnnotation = ImageAnnotation()
//                    }
//                }
//                dataTask.resume()
//            }
//        }
        print("all results:", self.annotations)
    }
}
