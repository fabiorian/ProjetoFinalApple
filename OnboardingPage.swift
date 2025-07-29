//
//  OnboardingPage.swift
//  DesApega
//
//  Created by found on 15/07/25.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let image: String // Assets
    let title: String
    let description: String
}

let onboardingPages = [
    OnboardingPage(image: "Logo", title: "Bem-vindo!", description: "Este app te ajuda a doar seus itens para quem precisa"),
    OnboardingPage(image: "Doador", title: "Identifique-se", description: "Escolha se você é um doador..."),
    OnboardingPage(image: "ONG", title: "", description: "...ou se você faz parte de uma ONG.")
]
