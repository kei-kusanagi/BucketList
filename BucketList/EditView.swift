//
//  EditView.swift
//  BucketList
//
//  Created by Juan Carlos Robledo Morales on 06/11/24.
//

import SwiftUI



struct EditView: View {
    
    var onSave: (Location) -> Void

    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel

   
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nombre del lugar", text: $viewModel.name)
                    TextField("Descripción", text: $viewModel.description)
                }
                Section("Cerca de ti…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Cargando…")
                    case .failed:
                        Text("Por favor, inténtalo de nuevo más tarde.")
                    }
                }

            }
            .navigationTitle("Detalles del lugar")
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = State(initialValue: ViewModel(location: location))
    }
    
}

#Preview {
    EditView(location: .example) { _ in }

}

