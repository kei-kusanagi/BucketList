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
    var location: Location

    @State private var name: String
    @State private var description: String

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nombre del lugar", text: $name)
                    TextField("Descripción", text: $description)
                }
            }
            .navigationTitle("Detalles del lugar")
            .toolbar {
                Button("Guardar") {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                }

            }
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

#Preview {
    EditView(location: .example) { _ in }

}

