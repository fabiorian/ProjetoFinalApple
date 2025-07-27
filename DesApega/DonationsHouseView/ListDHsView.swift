//
//  ListDHsView.swift
//  DesApega
//
//  Created by User on 22/07/25.
//

import SwiftUI
let DHsList: [DonationsHouse] = donationHouses()

struct ListDHsView: View {
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("Casas de Doação"), footer: Text("OI")){
                    ForEach(DHsList) { DH in
                        NavigationLink(destination: DHsOnClick(house: DH)){
                            DHsView(DHs: DH)
                        }
                    }
                }
            }
        }
    }
}
    #Preview {
        ListDHsView()
    }

