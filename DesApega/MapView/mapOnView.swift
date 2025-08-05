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
            ZStack {
                Color.black.ignoresSafeArea(.keyboard)
                MapViewController(
                    mapType: $selectedMapType,
                    donationHouse: donationHouses(),
                    DHonClick: { house in selectedHouse = house }
                )
                .ignoresSafeArea(edges: .top)
            }
            .tag(0)
            .tabItem {
                Image(systemName: "map")
                Text("Mapa")
            }


            HistoricView()
                .background(Color.black)
                .tag(1)
                .tabItem {
                    Image(systemName: "clock")
                    Text("Histórico")
                }
            ListDHsView()

                .background(Color.black)
                .tag(2)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Casas de Doações")
                }
            onBoardingView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .tag(3)
            .tabItem {
                Image(systemName: "questionmark.circle")
                Text("Sobre")
            }
        }
        .accentColor(.saffron) 
        .preferredColorScheme(.dark)
        .sheet(item: $selectedHouse) { house in
            DHsOnClick(house: house)
                .presentationDetents([.height(530)])
        }
        
    }
    
}


#Preview {
    mapOnView()
}
