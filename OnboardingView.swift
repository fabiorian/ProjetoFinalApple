//
//  OnboardingView.swift
//  DesApega
//
//  Created by found on 29/07/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    @State private var currentPage = 0
    @State private var navigateOnboarding = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(onboardingPages[currentPage].image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .padding()
                
                Text(onboardingPages[currentPage].title)
                    .font(.largeTitle)
                    .bold()
                
                Text(onboardingPages[currentPage].description)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                HStack {
                    if currentPage > 0 {
                        Button("Voltar") {
                            withAnimation {
                                currentPage -= 1
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    Button(currentPage == onboardingPages.count - 1 ? "Começar" : "Próximo") {
                        withAnimation {
                            if currentPage < onboardingPages.count - 1 {
                                currentPage += 1
                            } else {
                                showOnboarding = false
                                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                                navigateOnboarding = true
                            }
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                
                NavigationLink(destination: Doador(), isActive: $navigateOnboarding) {
                    EmptyView()
                }
            }
            .transition(.slide)
        }
    }
}
#Preview {
    struct Preview: View {
        @State private var show = true

        var body: some View {
            OnboardingView(showOnboarding: $show)
        }
    }

    return Preview()
}
