//
//  Doador.swift
//  DesApega
//
//  Created by found on 25/07/25.
//

import SwiftUI

struct Doador: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("Identifique-se")
                    .font(.title)
                    .fontWeight(.semibold)
                
                HStack(spacing: 40) {
                    NavigationLink(destination: mapOnView()) {
                        VStack(spacing: 20) {
                            Image("Doador")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 110)
                                .foregroundColor(.blue)
                            Text("Sou um doador")
                                .font(.headline)
                                .foregroundColor(.black)
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
        }
    }
}

#Preview {
    Doador()
}
