//
//  ContentView.swift
//  BucketList
//
//  Created by Juan Carlos Robledo Morales on 04/11/24.
//

import MapKit
import SwiftUI


struct ContentView: View {

    @State private var selectedPlace: Location?
    @State private var locations = [Location]()

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 19.42847 , longitude: -99.12766),
            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
          )
    )

    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate){
                        Image(systemName: "star.circle")
                            .resizable()
                                   .foregroundStyle(.red)
                                   .frame(width: 44, height: 44)
                                   .background(.white)
                                   .clipShape(.circle)
                                   .onLongPressGesture(minimumDuration: 0.2) { // Cambie la duración del gesto para que lo reconociera
                                       selectedPlace = location
                                   }
                    }
                }
            }
            .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = Location(id: UUID(), name: "Nueva ubicación", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(newLocation)
                    }
                }
            .sheet(item: $selectedPlace) { place in
                EditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }

            }

            
            }
    }
}

#Preview {
    ContentView()
}
