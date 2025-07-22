//
//  ListDHsView.swift
//  DesApega
//
//  Created by User on 22/07/25.
//

import SwiftUI

struct ListDHsView: View {
    let DHsList: [DonationsHouse] = donationHouses()
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("Casas de Doação"), footer: Text("OI")){
                    ForEach(DHsList) { DH in
//                        NavigationLink(destination: DHsView){
                            DHsView(DHs: DH)
//                        }
                    }
                }
            }
        }
    }
}
    #Preview {
        ListDHsView()
    }

