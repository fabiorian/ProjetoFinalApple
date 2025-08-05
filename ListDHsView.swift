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
                Section(header:
                        Text("Casas de Doação")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.indigo)
                        .padding(.top, 16)
                        .padding(.bottom, 12),
                        footer: Text("@Todos os direitos reservados ao enzo")){
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
