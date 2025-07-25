//
//  mapOnView.swift
//  DesApega
//
//  Created by User on 11/07/25.
//

import SwiftUI
import MapKit

let fortaleza = CLLocation(latitude: -20000 , longitude: 8.53994  )

var mapView: MKMapView!

struct mapOnView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingMap = false

    var body: some View {
        MapViewController()
            .edgesIgnoringSafeArea(.all)
//        Button("Casas de doação") {
//            showingMap = true
//        }
//        .sheet(isPresented: $showingMap){
//            cdView()
//        }
//        let fortalezaCoord2D = CLLocationCoordinate2D(latitude:-3.77165 , longitude: -38.53994)

    }
}

#Preview {
    mapOnView()
}
