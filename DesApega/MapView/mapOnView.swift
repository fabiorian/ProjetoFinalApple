//
//  mapOnView.swift
//  DesApega
//
//  Created by User on 11/07/25.
//

import SwiftUI
import MapKit


let fortaleza = CLLocation(latitude: -5.9 , longitude: -39.9)

struct mapOnView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingType = false
    @State private var selectedMapType: MKMapType = .standard
    @State var field = ""

    var body: some View {

        ZStack(alignment: .bottomTrailing) {
            MapViewController(mapType: $selectedMapType, donationHouse: DHsList)
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

    class ContentViewModel: ObservableObject {
        let results = [
            "oi", "oi nao"
        ]
    }
    var filtered: [String] = []

}

#Preview {
    mapOnView()
}


