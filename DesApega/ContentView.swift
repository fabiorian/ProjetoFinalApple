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
    @State private var desLettersVisible = [true, true, true]
    @State private var apegaLettersVisible = Array(repeating: true, count: 5)
    @State private var showSheet = false
    
    private let desAppearDelay: TimeInterval = 1.0
    private let apegaAppearDelay: TimeInterval = 2.0
    private let stayDuration: TimeInterval = 1.0
    private let letterFadeDelay: TimeInterval = 0.1
    
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            HStack(spacing: 0) {
                if showDes {
                    HStack(spacing: 0) {
                        ForEach(Array("Des".enumerated()), id: \.offset) { idx, char in
                            Text(String(char))
                                .font(.custom("Solitreo", size: 50))
                                .foregroundColor(.white)
                                .opacity(desLettersVisible[idx] ? 1 : 0)
                                .animation(
                                    .easeOut(duration: 0.3)
                                    .delay(Double(idx) * letterFadeDelay),
                                    value: desLettersVisible[idx]
                                )
                        }
                    }
                    .transition(.move(edge: .leading).combined(with: .opacity))
                }
                if showApega {
                    HStack(spacing: 0) {
                        ForEach(Array("Apega".enumerated()), id: \.offset) { idx, char in
                            Text(String(char))
                                .font(.custom("Solitreo", size: 50))
                                .foregroundColor(.white)
                                .opacity(apegaLettersVisible[idx] ? 1 : 0)
                                .animation(
                                    .easeOut(duration: 0.3)
                                    .delay(Double(idx) * letterFadeDelay),
                                    value: apegaLettersVisible[idx]
                                )
                        }
                    }
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            // animações de entrada
            .animation(.easeOut(duration: 0.5), value: showDes)
            .animation(.easeOut(duration: 0.5), value: showApega)
        }
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + desAppearDelay) {
                withAnimation { showDes = true }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + apegaAppearDelay) {
                withAnimation { showApega = true }
            }
            
            
            let desFadeStart = desAppearDelay + stayDuration
            for idx in desLettersVisible.indices {
                DispatchQueue.main.asyncAfter(deadline: .now() + desFadeStart + Double(idx) * letterFadeDelay) {
                    withAnimation { desLettersVisible[idx] = false }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + desFadeStart + Double(desLettersVisible.count) * letterFadeDelay + 0.1) {
                showDes = false
            }
            
            let apegaFadeStart = apegaAppearDelay + stayDuration
            for idx in apegaLettersVisible.indices {
                DispatchQueue.main.asyncAfter(deadline: .now() + apegaFadeStart + Double(idx) * letterFadeDelay) {
                    withAnimation { apegaLettersVisible[idx] = false }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + apegaFadeStart + Double(apegaLettersVisible.count) * letterFadeDelay + 0.1) {
                showApega = false
                showSheet = true
            }
        }
        .fullScreenCover(isPresented: $showSheet) {
            mapOnView()
        }
    }
}

#Preview {
    ContentView()
}


