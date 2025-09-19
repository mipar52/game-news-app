//
//  GameMetacriticStepper.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct GameMetacriticStepper: View {
    @State private var minMC: Int = 0
    @State private var maxMC: Int = 100
    @Binding var filters: GameSearchFilters
    
    var body: some View {
        HStack {
            Stepper("Min \(minMC)", value: $minMC, in: 0...100)
            Stepper("Max \(maxMC)", value: $maxMC, in: 0...100)
        }
        .onChange(of: minMC) { _ in filters.metacritic = minMC <= maxMC ? minMC...maxMC : nil }
        .onChange(of: maxMC) { _ in filters.metacritic = minMC <= maxMC ? minMC...maxMC : nil }

        if let mc = filters.metacritic { Text("Range: \(mc.lowerBound)–\(mc.upperBound)") }
    }
}

#Preview {
    @State var filters: GameSearchFilters = .default
    GameMetacriticStepper(filters: $filters)
}
