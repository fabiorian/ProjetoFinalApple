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
    @State private var donationHouse = [
        DonationsHouse(name: "Casa A", category: .clothe, description: "Roupas usadas", latitude: -3.715, longitude: -38.543),
        DonationsHouse(name: "Casa B", category: .toy, description: "Brinquedos diversos", latitude: -3.72, longitude: -38.55)
    ]


    var body: some View {



        Spacer()
        ZStack(alignment: .bottomTrailing) {
            MapViewController(mapType: $selectedMapType, donationHouse: donationHouse)
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


