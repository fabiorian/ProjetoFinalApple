//
//  Doador.swift
//  DesApega
//
//  Created by User on 04/08/25.
//

import SwiftUI



struct Doador: View {

    @State private var irParaMapa = false

    var body: some View {

        if irParaMapa {
            mapOnView()
        } else {
            VStack(spacing: 40) {
                Text("Identifique-se")
                    .font(.title)
                    .fontWeight(.semibold)

                HStack(spacing: 40) {
                    Button(action: {
                        irParaMapa = true
                    }) {
                        VStack(spacing: 20) {
                            Image("Doador")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 110)
                                .foregroundColor(.blue)
                            Text("Sou um doador")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    Divider()
                        .frame(height: 160)
                    VStack(spacing: 20) {
                        Image("ONG")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 80)
                            .foregroundColor(.blue)
                        Text("Sou uma ONG")
                            .font(.headline)

                        HStack(spacing: 6) {
                            Image(systemName: "clock")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Em breve...")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .opacity(0.5)

                }

            }
            .preferredColorScheme(.dark)

        }

    }

}



#Preview {

    Doador()

}

