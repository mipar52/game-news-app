//
//  SearchSuggestionView.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import SwiftUI

import SwiftUI

/// Reusable search prompt / empty state with an elevated CTA.
/// - Supports a NavigationLink destination or an action-based button.
/// - Optional suggestions rendered as chips.
struct SearchSuggestionView<Destination: View>: View {
    @EnvironmentObject private var theme: ThemeManager

    let title: String
    let subtitle: String
    let sfSymbol: String
    let ctaTitle: String
    let suggestions: [String]
    let onSuggestionTap: (String)?
    let destination: (() -> Destination)?
    let actionCTA: (() -> Void)?

    init(
        title: String = "Search for games",
        subtitle: String = "Try “Portal 2”, “Little Nightmares”, or “Lies of P”.",
        sfSymbol: String = "magnifyingglass",
        ctaTitle: String = "Looking for something else?",
        suggestions: [String] = [],
        onSuggestionTap: ((String))? = nil,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.title = title
        self.subtitle = subtitle
        self.sfSymbol = sfSymbol
        self.ctaTitle = ctaTitle
        self.suggestions = suggestions
        self.onSuggestionTap = onSuggestionTap
        self.destination = destination
        self.actionCTA = nil
    }

    init(
        title: String = "Search for games",
        subtitle: String = "Try “Portal 2”, “Little Nightmares”, or “horror platformer”.",
        sfSymbol: String = "magnifyingglass",
        ctaTitle: String = "Looking for something else?",
        suggestions: [String] = [],
        onSuggestionTap: ((String))? = nil,
        actionCTA: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.sfSymbol = sfSymbol
        self.ctaTitle = ctaTitle
        self.suggestions = suggestions
        self.onSuggestionTap = onSuggestionTap
        self.destination = nil
        self.actionCTA = actionCTA
    }

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: sfSymbol)
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(theme.colors.accent)

            Text(title)
                .font(.headline)
                .foregroundStyle(theme.colors.text)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(theme.theme.palette.text)
                .multilineTextAlignment(.center)

            if !suggestions.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(suggestions, id: \.self) { s in
                            Button {
                               // onSuggestionTap?(s)
                            } label: {
                                Text(s)
                                    .font(.caption.weight(.semibold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .foregroundStyle(theme.colors.text)
                                    .background(theme.colors.card, in: Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 2)
                }
            }

            if let destination {
                NavigationLink(destination: destination()) {
                    Label(ctaTitle, systemImage: "slider.horizontal.3")
                        .elevatedButton(bg: theme.colors.accent, fg: theme.colors.text)
                }
            } else if let actionCTA {
                Button(action: actionCTA) {
                    Label(ctaTitle, systemImage: "slider.horizontal.3")
                        .elevatedButton(bg: theme.colors.accent, fg: theme.colors.text)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(theme.colors.card)
                .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: 10)
        )
        .padding(.horizontal)
    }
}

