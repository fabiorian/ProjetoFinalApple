//
//  DHsOnClick.swift
//  DesApega
//
//  Created by User on 22/07/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct DHsOnClick: View {
    let house: DonationsHouse
    var showingRoute: ((CLLocationCoordinate2D) -> Void)?
    @State private var endereco: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        

        NavigationStack(){
            VStack(spacing: 12) {
//                Spacer()


                //            Capsule()
                //                .frame(width: 40, height: 5)
                //                .foregroundColor(.gray.opacity(0.3))
                //                .padding(.top, 8)
                Image(house.imageName ?? "placemaker")
                    .resizable()
                    .frame(width: 410, height: 300)
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
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
                            let destination = CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)
                            showingRoute?(destination)
                            dismiss()
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
                .frame(width: 384)
                .padding(.horizontal)

                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }

            .onAppear {
                house.reverseGeocoding { result in
                    endereco = result ?? "Endereço não disponível"
                }
            }
            .padding(.bottom, 200)

            .frame(maxWidth: .greatestFiniteMagnitude)
            
        }.navigationBarBackButtonHidden(true)


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
    DHsOnClick(house: DonationsHouse(name: "Nome", category: .clothe, description: "a[oigfhjweoifhjweoihjwojheoi2hjeoif", latitude: -3.895542, longitude: -38.70283,imageName: "Esperanca"))
}

