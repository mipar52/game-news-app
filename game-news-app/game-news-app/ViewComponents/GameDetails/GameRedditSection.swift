//
//  GameRedditSection.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameRedditSection: View {
    let url: URL?
    let logo: String?
    let displayName: String?     // redditName may be empty
    let description: String?
    let subscribers: Int?
    let twitchCount: Int?
    let youtubeCount: Int?

    @State private var expanded = false

    private var titleText: String {
        if let name = displayName, !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return name
        }
        if let sub = subredditName(from: url) {
            return "r/\(sub)"
        }
        return "Reddit"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack(spacing: 12) {
                if let logo = URL(string: logo ?? "") {
                    AsyncImage(url: logo) { phase in
                        switch phase {
                        case .success(let img): img.resizable().scaledToFill()
                        default:
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                                .resizable().scaledToFit().padding(8)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.orange.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }


                VStack(alignment: .leading, spacing: 2) {
                    Text(titleText).font(.headline)
                    HStack(spacing: 8) {
                        if let subscribers { Label("\(subscribers.compact) members", systemImage: "person.3") }
                        if let twitch = twitchCount, twitch > 0 { Label("\(twitch.compact) Twitch", systemImage: "bolt.horizontal") }
                        if let yt = youtubeCount, yt > 0 { Label("\(yt.compact) YouTube", systemImage: "play.rectangle.fill") }
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }

                Spacer()

                if let url {
                    Link(destination: url) {
                        Label("Open", systemImage: "safari")
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.plain)
                }
            }

            // Description (if present)
            if let desc = description, !desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(desc)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .lineLimit(expanded ? nil : 4)

                if desc.count > 140 {
                    Button(expanded ? "Show less" : "Read more") {
                        withAnimation(.easeInOut) { expanded.toggle() }
                    }
                    .font(.caption.weight(.semibold))
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func subredditName(from url: URL?) -> String? {
        guard let url, let comps = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        let parts = comps.path.split(separator: "/").map(String.init)
        if let rIndex = parts.firstIndex(of: "r"), parts.indices.contains(rIndex + 1) {
            return parts[rIndex + 1]
        }
        // Handle old-style or query-style URLs if needed
        return nil
    }
}

#Preview {
   // GameRedditSection()
}
