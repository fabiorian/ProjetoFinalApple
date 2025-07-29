//
//  DesApegaApp.swift
//  DesApega
//
//  Created by found on 04/07/25.
//

import SwiftUI

@main
struct DesApegaApp: App {
    var body: some Scene {
        WindowGroup {
            mapOnView()
        }
        .modelContainer(for: [Donation.self])
    }
}
