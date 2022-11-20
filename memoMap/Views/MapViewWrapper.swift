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

struct CoordinateRegion: Equatable {
  var center = LocationCoordinate2D()
  var span = CoordinateSpan()
}

extension CoordinateRegion {
  init(rawValue: MKCoordinateRegion) {
    self.init(
      center: .init(rawValue: rawValue.center),
      span: .init(rawValue: rawValue.span)
    )
  }

  var rawValue: MKCoordinateRegion {
    .init(center: self.center.rawValue, span: self.span.rawValue)
  }
}

struct LocationCoordinate2D: Equatable {
  var latitude: CLLocationDegrees = 0
  var longitude: CLLocationDegrees = 0
}

extension LocationCoordinate2D {
  init(rawValue: CLLocationCoordinate2D) {
    self.init(latitude: rawValue.latitude, longitude: rawValue.longitude)
  }

  var rawValue: CLLocationCoordinate2D {
    .init(latitude: self.latitude, longitude: self.longitude)
  }
}

struct CoordinateSpan: Equatable {
  var latitudeDelta: CLLocationDegrees = 0
  var longitudeDelta: CLLocationDegrees = 0
}

extension CoordinateSpan {
  init(rawValue: MKCoordinateSpan) {
    self.init(latitudeDelta: rawValue.latitudeDelta, longitudeDelta: rawValue.longitudeDelta)
  }

  var rawValue: MKCoordinateSpan {
    .init(latitudeDelta: self.latitudeDelta, longitudeDelta: self.longitudeDelta)
  }
}

extension MKLocalSearchCompletion {
  var id: [String] { [self.title, self.subtitle] }
}

struct MapState: Equatable {
    var completions: [MKLocalSearchCompletion] = []
    var query = ""
    var region = CoordinateRegion()
}

enum MapAction {
    case completionsUpdated(Result<[MKLocalSearchCompletion], Error>)
    case onAppear
    case queryChanged(String)
    case regionChanged(CoordinateRegion)
}

struct MapEnvironment {
    var searchCompleter: SearchCompleter
    
}

let mapReducer = AnyReducer<
  MapState,
  MapAction,
  MapEnvironment
> { state, action, environment in
  switch action {
  case let .completionsUpdated(.success(completions)):
    state.completions = completions
    return .none
    
  case let .completionsUpdated(.failure(error)):
    // TODO: error handling
    return .none
  
  case .onAppear:
    return environment.searchCompleter.completions()
      .map(MapAction.completionsUpdated)
    
  case let .queryChanged(query):
    state.query = query
    return environment.searchCompleter.search(query)
      .fireAndForget()

  case let .regionChanged(region):
    state.region = region
    return .none
  }
}



struct MapViewWrapper: View {
    @ObservedObject var mapViewController: MapViewController
    @ObservedObject var searchController: SearchController
    let store: Store<MapState, MapAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack(alignment: .top) {
                NavigationView {
                    MapView(mapViewController: mapViewController, searchController: searchController, annotations: searchController.annotations, currMemories: mapViewController.currMemories,
                            mapRegion: viewStore.binding(
                                get: \.region.rawValue,
                                send: { .regionChanged(.init(rawValue: $0)) }
                              )
                        )
                        .searchable(
                          text: viewStore.binding(
                            get: \.query,
                            send: MapAction.queryChanged
                          )) {
                              if viewStore.query.isEmpty {
                                  Spacer()
                                  Text("Coffee Shop")
                                  Text("Library")
                                  Text("Bathroom")
                              }
                              else {
                                  ForEach(viewStore.completions, id: \.id) { completion in
                                      VStack(alignment: .leading) {
                                          Text(completion.title)
                                      }
                                  }
                              }
                           }
                                    //                                placement: <#T##SearchFieldPlacement#>)
                                    //                            prompt: <#T##Text?#>,
                                    //                            suggestions:
                        .navigationBarTitleDisplayMode(.inline)
                        .edgesIgnoringSafeArea(.all)
                        .onAppear {
                            viewStore.send(.onAppear)
                        }
                    //            SearchView(mapViewController: mapViewController, searchController: searchController)
                    //            if searchController.searchQuery != "" {
                    ////                print("search query empty true")
                    //                SearchView(mapViewController: mapViewController, searchController: searchController)
                    //            }
                }
            }
        }
    }
}
