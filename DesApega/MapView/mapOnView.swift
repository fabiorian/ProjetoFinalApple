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
    @State private var selectTab = 0
    @Environment(\.dismiss) var dismiss
    @State private var showingType = false
    @State private var selectedMapType: MKMapType = .standard
    @State var field = ""
    @State var showingList: Bool = false
    @State private var selectedHouse: DonationsHouse? = nil
    
    
    var body: some View {
            TabView(selection: $selectTab) {
                ZStack(alignment: .bottomTrailing) {
                    MapViewController(mapType: $selectedMapType, donationHouse: donationHouses(), DHonClick: {
                        house in selectedHouse = house
                    })
                    .edgesIgnoringSafeArea(.top)
                    
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
                .tabItem {
                    Image(systemName: "map")
                    Text("mapa")
                }
                HistoricView()
                    .tabItem {
                        Image(systemName: "clock")
                        Text("Histórico")
                    }
                ListDHsView()
                    .tabItem{
                        Image(systemName: "list.bullet")
                        Text("Casas de Doações")
                    }
                VStack{
                    Text("quem ler é gay")
                }
                .tabItem{
                    Image(systemName: "questionmark.circle")
                    Text("Guia")
                }
            }
        }
    }


#Preview {
    mapOnView()
}


