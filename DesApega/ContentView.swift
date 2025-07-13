//
//  ContentView.swift
//  DesApega
//huuyuyu
//  Created by found on 04/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showDes = false
    @State private var showApega = false

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            HStack(spacing: 0) {
                if showDes {
                    Text("Des")
                        .font(Font.custom("Solitreo", size: 50))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
                if showApega {
                    Text("Apega")
                        .font(Font.custom("Solitreo", size: 50))
                        .foregroundColor(.white)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .animation(.easeOut(duration: 0.5), value: showDes)
            .animation(.easeOut(duration: 0.5), value: showApega)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showDes = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showApega = true
            }
        }
    }
}

#Preview {
    ContentView()
}


