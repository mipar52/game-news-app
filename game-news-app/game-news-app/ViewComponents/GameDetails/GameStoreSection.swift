//
//  GameStoreSection.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameStoreSection: View {
    let stores: [Store]
    let slug: String
    let name: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Stores").font(.headline).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(stores, id: \.id) { s in
                        if let url = storeURL(store: s, slug: slug, name: name) {
                            Link(destination: url) {
                                Text(s.name)
                                    .font(.caption.weight(.semibold))
                                    .padding(.horizontal, 12).padding(.vertical, 8)
                                    .background(Color.blue.opacity(0.15))
                                    .clipShape(Capsule())
                            }
                        } else {
                            Text(s.name)
                                .font(.caption.weight(.semibold))
                                .padding(.horizontal, 12).padding(.vertical, 8)
                                .background(Color.gray.opacity(0.15))
                                .clipShape(Capsule())
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }

    private func storeURL(store: Store, slug: String, name: String) -> URL? {
        // rawgio sometimes doesn’t provide a canonical product URL, so this is a somewhat fallback idk
        guard let domain = store.domain else { return nil }
        let q = (name.isEmpty ? slug : name).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? slug
        switch store.slug {
        case "steam": return URL(string: "https://\(domain)/search/?term=\(q)")
        case "gog": return URL(string: "https://\(domain)/game/\(slug)")
        case "apple-appstore": return URL(string: "https://\(domain)/us/search?term=\(q)")
        case "playstation-store": return URL(string: "https://\(domain)/en-us/search/\(q)")
        case "xbox-store": return URL(string: "https://\(domain)/en-us/search?q=\(q)")
        default: return URL(string: "https://\(domain)")
        }
    }}

#Preview {
  //  GameStoreSection()
}
