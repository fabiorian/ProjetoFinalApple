import MapKit
import Foundation
import CoreLocation
//import SwiftUICore

extension CLPlacemark {

    var address: String? {
        if let name = name {
            var result = name

            if let street = thoroughfare {
                result += ", \(street)"
            }

            if let city = locality {
                result += ", \(city)"
            }

            if let country = country {
                result += ", \(country)"
            }

            return result
        }

        return nil
    }

}
class DonationsHouseAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(house: DonationsHouse) {
        self.title = house.name
        self.subtitle = house.description
        self.coordinate = CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)
    }
}

class DonationsHouse: Identifiable {
    var id: UUID
    var name: String
    var category: Category
    var description: String
    var latitude: Double
    var longitude: Double
    var imageName: String?

    init(name: String, category: Category, description: String, latitude: Double, longitude: Double, imageName: String? = nil) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.imageName = imageName
    }

    var coordenadas: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    func reverseGeocoding(completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        let location = coordenadas

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Erro ao obter endereço: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }

            var addressComponents: [String] = []

            if let street = placemark.thoroughfare {
                addressComponents.append(street)
            }

            if let number = placemark.subThoroughfare {
                addressComponents.append(number)
            }

            if let neighborhood = placemark.subLocality {
                addressComponents.append(neighborhood)
            }

            if let city = placemark.locality {
                addressComponents.append(city)
            }

            if let state = placemark.administrativeArea {
                addressComponents.append(state)
            }

            if let country = placemark.country {
                addressComponents.append(country)
            }

            let formattedAddress = addressComponents.joined(separator: ", ")
            completion(formattedAddress)
        }
    }
}
//
//    enum Category: String, Codable {
//        case clothe = "Roupa"
//        case footwear = "Calçado"
//        case eletronic = "Eletrônico"
//        case toy = "Brinquedo"
//    }
//
//extension Category: CaseIterable{   }
//



func donationHouses() -> [DonationsHouse] {
    let house1 = DonationsHouse(
        name: "Casa da Esperança",
        category: .clothe,
        description: "Recebemos roupas de todos os tamanhos e para todas as idades.",
        latitude: -5.9 ,
        longitude: -39.9, // Exemplo de coordenada em Fortaleza
        imageName: "Esperanca"
    )

    let house2 = DonationsHouse(
        name: "Centro de Apoio Comunitário",
        category: .footwear,
        description: "Aceitamos calçados para nossa comunidade",
        latitude: -3.745000,
        longitude: -38.530000,// Exemplo de coordenada em Fortaleza
        imageName: "Image"
    )

    let house3 = DonationsHouse(
        name: "Lar dos Pequeninos",
        category: .toy,
        description: "Doe brinquedos usados ou em bom estado para crianças.",
        latitude: -3.720000,
        longitude: -38.510000, // Exemplo de coordenada em Fortaleza
        imageName: "Image"
    )

    let house4 = DonationsHouse(
        name: "Comunidade Ajude um Nerd",
        category: .eletronic,
        description: "Recebemos eletrônicos, no geral.",
        latitude: -3.750000,
        longitude: -38.540000, // Exemplo de coordenada em Fortaleza
        imageName: "Esperanca"
    )

    let house5 = DonationsHouse(
        name: "Guarda - Roupas Comunitário",
        category: .clothe,
        description: "Aceitamos doações de roupas para uso em nossa comunidade",
        latitude: -3.710000,
        longitude: -38.500000, // Exemplo de coordenada em Fortaleza
        imageName: "Image"
    )

    return [house1, house2, house3, house4, house5]
}

