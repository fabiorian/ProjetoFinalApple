
//
//  Untitled.swift
//  DesApega
//
//  Created by found on 27/07/25.
//

import Foundation
import SwiftData

enum Status: String, Codable {
    case muito_ruim = "Muito ruim"
    case ruim = "Ruim"
    case bom = "Bom"
    case muito_bom = "Muito bom"
    case otimo = "Ótimo"
}

extension Status: CaseIterable {  }

enum Category: String, Codable {
    case clothe = "Roupa"
    case footwear = "Calçado"
    case eletronic = "Eletrônico"
    case toy = "Brinquedo"
}

extension Category: CaseIterable {  }

@Model
class Donation {
    var id: UUID
    var name: String
    var status: Status
    var category: Category
    var detalhes: String
    var doador: String
    var local: String
    var time: Date
    var imageData: Data?

    init(
        id: UUID = UUID(),
        name: String,
        status: Status,
        category: Category,
        detalhes: String,
        doador: String,
        local: String,
        time: Date = Date(),
        imageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.category = category
        self.detalhes = detalhes
        self.doador = doador
        self.local = local
        self.time = time
        self.imageData = imageData
    }
}
