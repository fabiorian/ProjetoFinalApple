//
//  GuiaView.swift
//  DesApega
//
//  Created by User on 04/08/25.
//

import SwiftUI


struct GuiaView: View {

    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

    var body: some View {
        if showOnboarding {
            onBoardingView()
        } else {
            mapOnView()
                }
            }
        }
