//
//  ContentView.swift
//  BucketList
//
//  Created by Juan Carlos Robledo Morales on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Read and Write") {
            let data = Data("Test Message".utf8) // Convertimos un mensaje en datos
            let url = URL.documentsDirectory.appending(path: "message.txt") // Creamos la URL

            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection]) // Guardamos el archivo
                let input = try String(contentsOf: url) // Leemos el archivo
                print(input) // Imprimimos el contenido
            } catch {
                print(error.localizedDescription) // Manejamos errores
            }
        }

    }
}

#Preview {
    ContentView()
}
