//
//  onBoardingPage.swift
//  DesApega
//
//  Created by User on 04/08/25.
//

import SwiftUI


struct onBoardingPage: Identifiable{
    let id = UUID()
    let image: String
    let title: String
    let description: String
}


let onboardingPages = [

    onBoardingPage(image: "Logo", title: "Bem-vindo!", description: "Este app te ajuda a doar seus itens para quem precisa"),

    onBoardingPage(image: "Casas", title: "", description: "Escolha uma casa de doação"),

    onBoardingPage(image: "Adicionar", title: "", description: "E faça o anúncio, colocando o tipo de produto, qualidade, etc.")
]
