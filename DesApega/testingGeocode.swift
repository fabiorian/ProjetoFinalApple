//
//  testingGeocode.swift
//  DesApega
//
//  Created by User on 17/07/25.
//

import Foundation
import CoreLocation
import MapKit

func testing(){
    let myHouse = DonationsHouse(name: "casa do La ele", category: .eletronic, description: "aceitamos vibradores eletronicos como la eles", latitude: -3.732778, longitude: -38.526944, imageName: "")

    myHouse.reverseGeocoding{ address in
        if let address = address {
            print("Endereço da \(myHouse.name): \(address)")
        } else {
            print("Não foi possível obter o endereço para \(myHouse.name).")
        }
    }
}
