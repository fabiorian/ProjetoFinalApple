//
//  GuiaView.swift
//  DesApega
//
//  Created by found on 01/08/25.
//

import SwiftUI

struct GuiaView: View {
    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

    var body: some View {
        if showOnboarding {
            OnboardingView()
        } else {
            mapOnView()
                }
            }
        }
