//
//  MapView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//

import SwiftUI
import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {

    var parent: MapView

      init(_ parent: MapView) {
          self.parent = parent
      }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation selected!!!")
        guard let pin = view.annotation as? ImageAnnotation else {
            return
        }
        mapView.setCenter(pin.coordinate, animated: true)
    
        DispatchQueue.main.async {
            self.parent.selectedPin = pin
            self.parent.isBottomSheetOpen = true
        }
      }

      func mapView(_ mapView: MKMapView, viewFor
           annotation: MKAnnotation) -> MKAnnotationView? {
            print("annotation coordinator: ", annotation)
//            //Custom View for Annotation
//            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "customView")
//            annotationView.canShowCallout = true
//            //Your custom image icon
//            annotationView.image = UIImage(named: "locationPin")
//            return annotationView
          
          if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
              print("user location here 1")
              return nil  //Default is to let the system handle it.
          }
          
//          if annotation.image == nil {
//              var defaultAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "DefaultPinView")
//              if defaultAnnotationView == nil {
//                  print("2a here")
//                  defaultAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DefaultPinView")
//                  defaultAnnotationView?.image = UIImage(named: "locationPin")
//              }
//              defaultAnnotationView?.canShowCallout = true
//              return defaultAnnotationView
//          }

          if !annotation.isKind(of: ImageAnnotation.self) {
              print("original here 2")
              var defaultAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "DefaultPinView")
              if defaultAnnotationView == nil {
                  print("2a here")
                  defaultAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DefaultPinView")
                  defaultAnnotationView?.image = UIImage(named: "locationPin")
              }
              defaultAnnotationView?.canShowCallout = true
              return defaultAnnotationView
          }

          //Custom View for Annotation
          print("image here 3")
          var view: ImageAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "customLocationAnnotation") as? ImageAnnotationView
          if view == nil {
              view = ImageAnnotationView(annotation: annotation, reuseIdentifier: "customLocationAnnotation")
          }
          let annotation = annotation as! ImageAnnotation
          view?.image = annotation.image
          view?.annotation = annotation
          return view
       }
//        @objc func loadAnnotations() {
//
//            for item in locations{
//                DispatchQueue.main.async {
//                    let request = NSMutableURLRequest(url: URL(string: "<YourPictureUrl>")!)
//                    request.httpMethod = "GET"
//                    let session = URLSession(configuration: URLSessionConfiguration.default)
//                    let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
//                        if error == nil {
//
//                            let annotation = ImageAnnotation()
//                            annotation.coordinate = CLLocationCoordinate2DMake(Double(item["pl_lat"] as! String)!,
//                                                                               Double(item["pl_long"] as! String)!)
//                            annotation.image = UIImage(data: data!, scale: UIScreen.main.scale)
//                            annotation.title = "T"
//                            annotation.subtitle = ""
//                            DispatchQueue.main.async {
//                                self.mapView.addAnnotation(annotation)
//                            }
//                        }
//                    }
//
//                    dataTask.resume()
//                }
//            }
//        }
    
}

struct MapView: UIViewRepresentable {
    
  @ObservedObject var mapViewController: MapViewController
  @ObservedObject var searchController: SearchController
//  @ObservedObject var placeController: PlaceController
  @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(40.444230, -79.945530), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

//    private func addMapAnnotations(from mapView: MKMapView) {
//        let test_locations = [
//            ["name": "Delainie's Coffee", "latitude": 40.4288961, "longitude": -79.9807498,],
//            ["name": "Bird on the Run South Side", "latitude": 40.4290, "longitude": -79.9809],
//            ["name": "Insomnia Cookies", "latitude": 40.428620, "longitude": -79.980860],
//            ["name": "Bruegger's Bagels", "latitude": 40.428951, "longitude": -79.980377],
//        ]
//        for location in test_locations {
//            print("location: ", location)
//            let annotation = MKPointAnnotation()
//            annotation.title = location["name"] as? String
//
//            let loc = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//            annotation.coordinate = loc
//            mapView.addAnnotation(annotation)
//            print("added")
//        }
//    }
//    @Binding var selectedPlace: ImageAnnotation?
    var annotations = [ImageAnnotation]()
    var currMemories = [ImageAnnotation]()
    let mapView = MKMapView(frame: .zero)
    @Binding var selectedPin: ImageAnnotation?
    @Binding var isBottomSheetOpen: Bool
//    @Binding var mapRegion : MKCoordinateRegion

    func makeCoordinator() -> MapViewCoordinator {
            MapViewCoordinator(self)
        }
    
//    private func updateMemories(from mapView: MKMapView) {
//        mapView.removeAnnotations(mapView.annotations)
//            let newAnnotations = currMemories.map { LandmarkAnnotation(landmark: $0) }
//            mapView.addAnnotations(newAnnotations)
//            if let selectedAnnotation = newAnnotations.first(where: { $0.id == selectedLandmark?.id }) {
//                mapView.selectAnnotation(selectedAnnotation, animated: true)
//            }
//    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("updating")
//        addExistingMemories()
        uiView.showsUserLocation = true
//        uiView.annotations.forEach { uiView.removeAnnotation($0) }
        loadAnnotations()
//        mapViewController.current.loadLocation()
//        mapViewController.getNearbyLocations(using: MKLocalSearch.Request())
        uiView.delegate = context.coordinator
//        uiView.register(ImageAnnotationView.self, forAnnotationViewWithReuseIdentifier: "customLocationAnnotation")
        print("map annotations:", annotations)
//        uiView.addAnnotations(annotations)
//        loadSearchImage()
        uiView.addAnnotations(annotations)
        uiView.showAnnotations(annotations, animated: true)
//        uiView.addAnnotations(searchViewController.searchAnnotations)
  }
    typealias UIViewType = MKMapView

//    mutating func getSearchResults () {
//        self.searchResults = searchViewController.getSearchResults()
//    }

//    func loadSearchImage() {
//        for annotation in annotations {
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
//    }
    
    func loadAnnotations() {
        print("CURR MEMORIES: ", currMemories)
        for memory in currMemories {
            DispatchQueue.main.async {
                let request = NSMutableURLRequest(url: URL(string: memory.url)!)
                request.httpMethod = "GET"
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                    if error == nil {
                        let loc = LocationAnnotation(title: memory.title ?? "", subtitle: memory.subtitle ?? "", coordinate: memory.coordinate)
                        let annotation = ImageAnnotation(locAnnotation: loc)
//                        annotation.coordinate = memory.coordinate
                        annotation.image = UIImage(data: data!, scale: UIScreen.main.scale)
                        annotation.image!.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: annotation.image!.size.height/2, right: 0))
//                        annotation.title = memory.title
//                        annotation.subtitle = memory.subtitle
//                        let locAnnotation = LocationAnnotation(title: memory.title, subtitle: memory.subtitle, coordinate: )
                        
//                        let imageAnnotation = ImageAnnotation()
                        
                        DispatchQueue.main.async {
                            self.mapView.addAnnotation(annotation)
                            print("added 1")
                        }
                    }
                }
                dataTask.resume()
            }
        }
    }
    
//    func loadImageFromURL (_ url: String) -> UIImage {
//        let request = NSMutableURLRequest(url: URL(string: url)!)
//        request.httpMethod = "GET"
//        var image = UIImage()
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
//            if error == nil {
//                image = UIImage(data: data!, scale: UIScreen.main.scale) ?? UIImage()
//            }
//        }
//        return image
//    }

    private func setUpMapRegion() {
        mapViewController.current.getCurrentLocation()
        let coordinate = CLLocationCoordinate2D(latitude: mapViewController.current.latitude, longitude: mapViewController.current.longitude
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
    }
    
    func makeUIView(context: Context) -> MKMapView {
      mapView.delegate = context.coordinator
      mapView.register(ImageAnnotationView.self, forAnnotationViewWithReuseIdentifier: "customLocationAnnotation")
      setUpMapRegion()
//      getSearchResults()
//        mapView.addAnnotations(searchViewController.searchAnnotations)
//
//      // TODO: figure out how to move to MapViewController
////      userLocation.loadLocation()
//
//      mapViewController.addMapAnnotations()
    return mapView
  }
}



//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
