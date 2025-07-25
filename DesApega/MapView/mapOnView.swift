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
    @State var showingList: Bool = false
    @State private var selectedHouse: DonationsHouse? = nil

    
    var body: some View {
        NavigationView{

            ZStack(alignment: .bottomTrailing) {
                MapViewController(mapType: $selectedMapType, donationHouse: donationHouses(), DHonClick: {
                    house in selectedHouse = house
                })
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

            .toolbar {
                ToolbarItem(placement: .bottomBar) {

                    Button(action: {
                        showingList = true
                    }) {
                        Label("Adicionar", systemImage: "list.bullet")
                    }

                }
            }
            .sheet(isPresented: $showingList){
                ListDHsView()
                    .presentationDetents([.medium])
            }
            .sheet(item: $selectedHouse) { house in
                            DHsOnClick(house: house)
                    .presentationDetents([.medium])
                }

        }
//        class ContentViewModel: ObservableObject {
//            let results = [
//                "oi", "oi nao"
//            ]
//        }
//        var filtered: [String] = []

    }
}
#Preview {
    mapOnView()
}


