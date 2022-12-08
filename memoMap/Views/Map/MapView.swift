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
        print("region changed handling clustering")
        print("handling: ", self.parent.clusterManager.annotations)
        self.parent.clusterManager.reload(mapView: mapView) { finished in
            // handle completion
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor
                 annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
            print("user location here 1")
            return nil  //Default is to let the system handle it.
        }
        
        if let annotation = annotation as? ClusterAnnotation {
            print("entered cluster!!")
            return CountClusterAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
        }
    
        
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
//        print("image here 3")
        var view: ImageAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "customLocationAnnotation") as? ImageAnnotationView
        if view == nil {
            view = ImageAnnotationView(annotation: annotation, reuseIdentifier: "customLocationAnnotation")
        }
        let annotation = annotation as! ImageAnnotation
        view?.image = annotation.image
        view?.annotation = annotation
        return view
    }
    
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
            
            
            // TODO: spearate
            let remove = uiView.annotations.filter({ !($0 is MKUserLocation) && (($0 is ImageAnnotation) && !(isMemory(imgAnnotation: $0 as! ImageAnnotation ))) })
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
        print("cluster before removal", clusterManager.annotations)
        let curr_user = memoryController.getCurrentUser()
        if (self.ownView) {
            print("updating: your own memories")
//            clusterManager.removeAll()
            let my_mems = memoryController.getMemoryPinsForUser(user: curr_user)
            mapView.addAnnotations(my_mems)
            clusterManager.add(my_mems)
            print("cluster after add 1", clusterManager.annotations)
            //            mapView.showAnnotations(my_mems, animated: false)
        } else {
            print("updating: friends + your memories")
//            clusterManager.removeAll()
            let world_mems = memoryController.getFriendsMemoryPins(user: curr_user)
            mapView.addAnnotations(world_mems)
            clusterManager.add(world_mems)
            print("cluster after add 2", clusterManager.annotations)
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
