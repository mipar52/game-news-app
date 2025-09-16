//
//  GameFiltersSheet.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct GameFiltersSheet: View {
    @Binding var filters: GameSearchFilters
    let allGenres: [GameGenre]
    let allPlatforms: [Platform]
    
    @Environment(\.dismiss) var dismiss
    @State private var minimalMetaCritic: Int = 0
    @State private var maximumMetaCritic: Int = 100
    @State private var fromDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
    @State private var toDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Set search behaviour") {
                    Toggle("Exact search", isOn: $filters.exact)
                    Toggle("Precise: (no fuzziness)", isOn: $filters.precise)
                }
                
                Section("Metacritic") {
                    HStack {
                        Stepper("Min \(minimalMetaCritic)", value: $minimalMetaCritic, in: 0...100)
                        Stepper("Max \(maximumMetaCritic)", value: $maximumMetaCritic, in: 0...100)
                    }
                    .onChange(of: minimalMetaCritic) { _ in filters.metacritic = minimalMetaCritic <= maximumMetaCritic ? minimalMetaCritic...maximumMetaCritic : nil }
                    .onChange(of: maximumMetaCritic) { _ in filters.metacritic = minimalMetaCritic <= maximumMetaCritic ? minimalMetaCritic...maximumMetaCritic : nil }
                    
                    if let mc = filters.metacritic { Text("Range: \(mc.lowerBound)–\(mc.upperBound)") }

            }
            
                
                //            Section("Genres") {
                //                MultiSelectList(
                //                    all: allGenres.map(\.slug),
                //                    selected: Binding(
                //                        get: { Set(filters.genres) },
                //                        set: { filters.genres = Array($0).sorted() }
                //                    ),
                //                    labelProvider: { slug in allGenres.first(where: { $0.slug == slug })?.name ?? slug }
                //                )
                //            }
            }
        }
    }
}

#Preview {
    @Previewable @State var filters: GameSearchFilters = .init()
    
    GameFiltersSheet(filters: $filters, allGenres: [
        GameGenre(id: 0, name: "Horror", slug: "horror", gamesCount: 10000, imageBackground: "jpg"),
        GameGenre(id: 0, name: "First person shooter (FPS)", slug: "fps", gamesCount: 10000, imageBackground: "jpg")
    ], allPlatforms: [
        Platform(id: 0, name: "PlayStation 5", slug: "ps5"),
        Platform(id: 1, name: "XBox Series X", slug: "xbox-series-x"),
    ])
}
