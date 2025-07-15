//
//  ContentView.swift
//  DesApega
//
//  Created by found on 04/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "star")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Foundation!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
