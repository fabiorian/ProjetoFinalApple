//
//  Donation.swift
//  DesApega
//
//  Created by User on 11/07/25.
//


import SwiftUI
import Foundation
import SwiftData


enum Status: String, Codable {
    case muito_ruim = "Muito ruim"
    case ruim = "Ruim"
    case bom = "bom"
    case muito_bom = "Muito bom"
    case otimo = "Ótimo"
}

extension Status: CaseIterable{   }

enum Category: String, Codable {
    case clothe = "Roupa"
    case footwear = "Calçado"
    case eletronic = "Eletrônico"
    case toy = "Brinquedo"
}

extension Category: CaseIterable{   }

class Donation: Identifiable {
    init (name: String, status: Status, category: Category, description: String, doador: String, time: Date){
        self.name = name
        self.status = status
        self.category = category
        self.description = description
        self.doador = doador
    }
    var name: String
    var status: Status
    var category: Category
    var doador: String
    var description: String
    var time: Date()
}


