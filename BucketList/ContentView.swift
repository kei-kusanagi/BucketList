//
//  ContentView.swift
//  BucketList
//
//  Created by Juan Carlos Robledo Morales on 04/11/24.
//

import SwiftUI


enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Cargando...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("¡Éxito!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Fallido.")
    }
}


struct ContentView: View {
    
    @State private var loadingState = LoadingState.success

    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

#Preview {
    ContentView()
}
