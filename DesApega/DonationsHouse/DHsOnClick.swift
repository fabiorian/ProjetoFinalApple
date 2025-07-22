//
//  DHsOnClick.swift
//  DesApega
//
//  Created by User on 22/07/25.
//

import SwiftUI

struct DHsOnClick: View {
    let house: DonationsHouse
    @State private var endereco: String = ""


    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 8)

            VStack(alignment: .leading, spacing: 8) {
                Text(house.name)
                    .font(.title2)
                    .fontWeight(.semibold)

                Label("Endereço: \(endereco)", systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Label("Tipo: \(house.category.rawValue)", systemImage: iconForCategory(house.category))
                    .font(.subheadline)
                    .foregroundColor(.blue)

                Label("Descrição: \(house.description)", systemImage: "info.circle")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                HStack {
                    Spacer()
                    Button(action: {
                        // Ação de rota, se desejar implementar
                    }) {
                        Label("Ver rota", systemImage: "location.fill")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(.top, 8)
            }
            .padding(.horizontal)

            Spacer()
        }
        .onAppear {
            house.reverseGeocoding { result in
                endereco = result ?? "Endereço não disponível"
            }
        }
        .padding(.bottom, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 10)
        )
        .frame(maxWidth: .infinity)
    }
}

func iconForCategory(_ category: Category) -> String {
    switch category {
    case .clothe: return "tshirt"
    case .footwear: return "shoeprints.fill"
    case .eletronic: return "cpu"
    case .toy: return "gamecontroller.fill"
    }
}

#Preview {
    DHsOnClick(house: DonationsHouse(name: "NOME", category: .clothe, description: "apifoioaf", latitude: -3.90469232, longitude: -38.323526))
}
