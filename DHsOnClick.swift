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
//            Capsule()
//                .frame(width: 40, height: 5)
//                .foregroundColor(.gray.opacity(0.3))
//                .padding(.top, 8)
            Image(house.imageName ?? "placemaker")
                .resizable()
                .aspectRatio(contentMode: .fit)
                   .scaledToFill()
                   .frame(height: .infinity)
                   .clipped()
                   .cornerRadius(12)
                   .padding(.horizontal)

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
                    NavigationLink(destination: DesApegaView()) {
                        Label("Adicionar Doação", systemImage: "plus")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(Color.green)
//                            .cornerRadius(20)
                            
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
        .padding(.bottom, 200)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color(.systemBackground))
//                .shadow(radius: 10)
//        )
        .frame(maxWidth: .greatestFiniteMagnitude)
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
    DHsOnClick(house: DonationsHouse(name: "Nome", category: .clothe, description: "a[oigfhjweoifhjweoihjwojheoi2hjeoif", latitude: -3.895542, longitude: -38.70283,imageName: "dhs1"))
}
