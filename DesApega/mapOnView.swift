//
//  mapOnView.swift
//  DesApega
//
//  Created by User on 11/07/25.
//

import SwiftUI
import MapKit


let fortaleza = CLLocation(latitude: -3.71722 , longitude: -38.54333)

struct mapOnView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingType = false
    @State private var selectedMapType: MKMapType = .standard

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            MapViewController(mapType: $selectedMapType)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Picker("Tipo de Mapa", selection: $selectedMapType) {
                        Text("Padrão").tag(MKMapType.standard)
                        Text("Satélite").tag(MKMapType.hybrid)
                    }
                    .pickerStyle(.menu)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    mapOnView()
}
