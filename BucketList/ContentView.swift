//
//  ContentView.swift
//  BucketList
//
//  Created by Juan Carlos Robledo Morales on 04/11/24.
//

import MapKit
import SwiftUI


struct ContentView: View {

    enum MapDisplayType: String, CaseIterable {
        case standard
        case hybrid
        case satellite
        

        var mapStyle: MapStyle {
            switch self {
            case .standard:
                return .standard
            case .hybrid:
                return .hybrid
            case .satellite:
                return .imagery
                        }
        }
    }


    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 19.42847 , longitude: -99.12766),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
          )
    )

    @State private var viewModel = ViewModel()
    @AppStorage("mapStyle") private var mapStyleString = MapDisplayType.standard.rawValue
       private var mapDisplayType: MapDisplayType {
           get { MapDisplayType(rawValue: mapStyleString) ?? .standard }
           set { mapStyleString = newValue.rawValue }
       }

    var body: some View {
        
        if viewModel.isUnlocked {
            VStack {
                Picker("Map mode", selection: $mapStyleString) {
                          ForEach(MapDisplayType.allCases, id: \.self) { type in
                              Text(type.rawValue.capitalized).tag(type.rawValue)
                          }
                      }
                      .pickerStyle(.segmented)
                      .padding(.horizontal)
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate){
                                Image(systemName: "mappin.and.ellipse")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
//                                    .background(.white)
//                                    .clipShape(.circle)
                                    .onLongPressGesture(minimumDuration: 0.2) { // Cambie la duración del gesto para que lo reconociera
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(mapDisplayType.mapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                        
                    }
                    
                    
                }
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)

        }
    }
}

#Preview {
    ContentView()
}
