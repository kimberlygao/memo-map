//
//  MapView.swift
//  memoMap
//
//  Created by Kimberly Gao on 11/2/22.
//
import SwiftUI
import MapKit
import Cluster

//class MKOverlayRenderer {
//    var blendMode: CGBlendMode =
//}
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
//        mapView.setCenter(pin.coordinate, animated: true)
        
        DispatchQueue.main.async {
            self.parent.selectedPin = pin
            self.parent.isBottomSheetOpen = true
            print("selected pin: ", self.parent.selectedPin)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.parent.clusterManager.reload(mapView: mapView) { finished in
            // handle completion
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
        
        if let annotation = annotation as? ClusterAnnotation {
            print("entered cluster!!")
            return CountClusterAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
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
            //              let base = UIView(frame: CGRect(x: 0, y: 0, width: 67, height: 26))
            //              let imageView = UIImageView(frame: CGRect(x: 2, y: 2, width: 22, height: 22))
            //              imageView.image = UIImage(named: "test")
            //
            //              base.layer.cornerRadius = 3.0
            //              base.clipsToBounds = true
            //              base.backgroundColor = .white
            //              base.addSubview(imageView)
            //
            //              view?.addSubview(base)
            //              view?.canShowCallout = true
            //              view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
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
    
    let mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    @ObservedObject var memoryController: MemoryController
    let clusterManager = ClusterManager()
    var annotations = [ImageAnnotation]()
    var currMemories = [ImageAnnotation]()
    let mapView = MKMapView(frame: .zero)
    
    @Binding var selectedPin: ImageAnnotation?
    @Binding var isBottomSheetOpen: Bool
    @Binding var ownView: Bool
    @Binding var findUser: Bool
    //    @Binding var mapRegion : MKCoordinateRegion
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    private func isMemory (imgAnnotation: ImageAnnotation) -> Bool {
        return (imgAnnotation.isMemory == true)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("updating")
        //        uiView.removeAnnotations(remove)
        uiView.delegate = context.coordinator
        uiView.showsUserLocation = true
        print("before enter casing:", annotations, currMemories)
        print("issearching?", searchController.isSearching)
        
        if (self.findUser) {
            mapViewController.current.getCurrentLocation()
            print("user location: ", mapViewController.current.longitude,  mapViewController.current.latitude)
            let coordinate = CLLocationCoordinate2D(latitude: mapViewController.current.latitude, longitude: mapViewController.current.longitude
            )
            let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            uiView.setRegion(region, animated: true)
            self.findUser = false
        }
        
    
        if (searchController.searchQuery == "") {
            //            uiView.removeAnnotations(remove)
            print("case 1: empty query")
            
            let remove = uiView.annotations.filter({ !($0 is MKUserLocation) && !(isMemory(imgAnnotation: $0 as! ImageAnnotation )) })
            uiView.removeAnnotations(remove)
            print("own view?", self.ownView)
            if !(searchController.isSearching) {
                print("not searching")
                setUpMemories(from: uiView)
            }
        }
        // memories disappear
        else {
            print("case 2: searching")
            let remove = uiView.annotations.filter({!($0 is MKUserLocation) && ($0 is ImageAnnotation) })
            uiView.removeAnnotations(remove)

            uiView.addAnnotations(annotations)
            uiView.showAnnotations(annotations, animated: true)
//            loadAnnotations()
//            let remove = uiView.annotations.filter({ !($0 is MKUserLocation) && ($0 is ImageAnnotation && (isMemory(imgAnnotation: $0 as! ImageAnnotation) ))  })
//            uiView.removeAnnotations(remove)
        }
    }
    
    func addSearchCluster() {
        for annotation in annotations {
            clusterManager.add(annotation)
        }
    }
    
    private func setUpMapRegion(from mapView: MKMapView) {
        mapViewController.current.getCurrentLocation()
        let coordinate = CLLocationCoordinate2D(latitude: mapViewController.current.latitude, longitude: mapViewController.current.longitude
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func setUpMemories(from mapView: MKMapView) {
        let curr_user = memoryController.getCurrentUser()
        if (self.ownView) {
            print("updating: your own memories")
            let my_mems = memoryController.getMemoryPinsForUser(user: curr_user, prompt: false)
                mapView.addAnnotations(my_mems)
//            mapView.showAnnotations(my_mems, animated: false)
        } else {
            print("updating: friends + your memories")
            let world_mems = memoryController.getFriendsMemoryPins(user: curr_user, prompt: false)
                mapView.addAnnotations(world_mems)
//                mapView.showAnnotations(world_mems, animated: false)
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        print("map set up!!")
        mapView.delegate = context.coordinator
        mapView.register(ImageAnnotationView.self, forAnnotationViewWithReuseIdentifier: "customLocationAnnotation")
        setUpMapRegion(from: mapView)
        //      mapView.overrideUserInterfaceStyle = .dark
        let config = MKStandardMapConfiguration(emphasisStyle: .muted)
        config.pointOfInterestFilter = .some(MKPointOfInterestFilter(including: []))
        mapView.preferredConfiguration = config
        //    colorMap(from: mapView)
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
