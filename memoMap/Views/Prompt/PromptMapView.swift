//
//  PromptMapView.swift
//  memoMap
//
//  Created by Fiona Chiu on 2022/12/6.
//

import Foundation
import SwiftUI
import MapKit

class PromptMapViewCoordinator: NSObject, MKMapViewDelegate {
    
    var parent: PromptMapView
    
    init(_ parent: PromptMapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation selected!!!")
        guard let pin = view.annotation as? ImageAnnotation else {
            return
        }
        
        DispatchQueue.main.async {
            self.parent.selectedPin = pin
            self.parent.isBottomSheetOpen = true
            print("selected pin: ", self.parent.selectedPin)
        }
    }
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        self.parent.clusterManager.reload(mapView: mapView) { finished in
//            // handle completion
//        }
//    }
    
    func mapView(_ mapView: MKMapView, viewFor
                 annotation: MKAnnotation) -> MKAnnotationView? {
        print("annotation coordinator: ", annotation)
        
        if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
            print("user location here 1")
            return nil  //Default is to let the system handle it.
        }
        
        //        if let annotation = annotation as? ClusterAnnotation {
        //            print("entered cluster!!")
        //            return CountClusterAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
        //        }
        
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
}

struct PromptMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        print("map set up!!")
        mapView.delegate = context.coordinator
        mapView.register(ImageAnnotationView.self, forAnnotationViewWithReuseIdentifier: "customLocationAnnotation")
        setUpMapRegion(from: mapView)
        let config = MKStandardMapConfiguration(emphasisStyle: .muted)
        config.pointOfInterestFilter = .some(MKPointOfInterestFilter(including: []))
        mapView.preferredConfiguration = config
        return mapView
    }
    
    
    @Binding var selectedPin: ImageAnnotation?
    @Binding var isBottomSheetOpen: Bool
    let mapViewController: MapViewController
    @ObservedObject var memoryController: MemoryController
    let mapView = MKMapView(frame: .zero)
    @Binding var findUser: Bool
    @Binding var answered: Bool
    
    func makeCoordinator() -> PromptMapViewCoordinator {
        PromptMapViewCoordinator(self)
    }
    
    private func setUpMapRegion(from mapView: MKMapView) {
        mapViewController.current.getCurrentLocation()
        let coordinate = CLLocationCoordinate2D(latitude: mapViewController.current.latitude, longitude: mapViewController.current.longitude
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("updating")
        uiView.delegate = context.coordinator
        uiView.showsUserLocation = true
        
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
        print("answered?: ", self.answered)
        if (self.answered) {
            let curr_user = memoryController.getCurrentUser()
            let prompt_mems = memoryController.getDailyPins(user: curr_user)
            print("prompt mems: ", prompt_mems)
            uiView.addAnnotations(prompt_mems)
        }

    }
}
