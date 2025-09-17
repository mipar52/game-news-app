//
//  SettingsView.swift
//  game-news-app
//
//  Created by Milan Parađina on 17.09.2025..
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var theme: ThemeManager
    @State private var isExactSearchEnabled: Bool = false
    @State private var isPreciseSearchEnabled: Bool = false
    @State private var isLiquidGlassEnabled: Bool = false

    var body: some View {
        NavigationStack {
                Form {
                    Section("Onboarding") {
                        NavigationLink {
                            OnboardingView()
                        } label: {
                            Text("Go through onboarding again")
                        }
                    }
                    
                Section(header: Text("Search options")) {
                    Toggle("Enable exact search", isOn: $isExactSearchEnabled)
                    Toggle("Enable precise search (no fuzziness)", isOn: $isPreciseSearchEnabled)
                }
                    

                    Section("Application Theme") {
                        HStack(spacing: 12) {
                            ForEach(AppTheme.allCases) { t in
                                VStack {
                                    ThemeShower(theme: t, selected: theme.theme == t) {
                                        theme.setTheme(t)
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    Text(t.name)
                                        .font(.caption)
                                        .foregroundStyle(t.palette.text)
                                }

                            }
                        }
                        .listRowInsets(EdgeInsets()) // makes the row breathe
                        .padding(.vertical, 6)
                    }

                    
                    Section("Liquid glass") {
                        Toggle("Enable liquid glass", isOn: $isLiquidGlassEnabled)
                    }
            }
                .navigationTitle("GameNEWS Settings")
        }
        
    }
}

#Preview {
    SettingsView()
}
