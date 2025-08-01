//
//  ListDHsView.swift
//  DesApega
//
//  Created by User on 22/07/25.
//

import SwiftUI

let DHsList: [DonationsHouse] = donationHouses()

struct ListDHsView: View {
    @State private var selectedCategory: Category? = nil

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Casas de Doações")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(20)

//                 Botão de filtro logo abaixo do título

                Menu {
                    Button("Todos", action: { selectedCategory = nil })
                    ForEach(Category.allCases, id: \.self) { category in
                        Button(category.rawValue) {
                            selectedCategory = category
                        }
                    }
                }label: {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease")
                    }
                    .padding() 
            }

                List {
                    Section() {
                        ForEach(filteredDHs) { DH in
                            NavigationLink(destination: DHsOnClick(house: DH)) {
                                DHsView(DHs: DH)
                            }
                        }
                    }
                }
                
                .listStyle(.plain)
            }
        }
    }

    var filteredDHs: [DonationsHouse] {
        guard let selected = selectedCategory else {
            return DHsList
        }
        return DHsList.filter { $0.category == selected }
    }
}

#Preview {
    ListDHsView()
}
