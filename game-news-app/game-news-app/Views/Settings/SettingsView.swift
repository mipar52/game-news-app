//
//  SettingsView.swift
//  game-news-app
//
//  Created by Milan Parađina on 17.09.2025..
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var settings: SettingsStore
    @EnvironmentObject private var theme: ThemeManager
    
    var body: some View {
            ZStack {
                LinearGradient(
                    colors: [theme.theme.palette.background, theme.theme.palette.accent],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .ignoresSafeArea(.all)

                Form {
                    Section {
                        NavigationLink {
                            OnboardingView()
                        } label: {
                            Text("Go through onboarding again")
                        }
                    } header: {
                        FormSectionHeader(text: "Onboarding")
                    }
                    .listRowBackground(theme.theme.palette.card)
                    
                    Section {
                        Toggle("Enable exact search", isOn: $settings.useExactSearch)
                        Toggle("Enable precise search (no fuzziness)", isOn: $settings.usePreciseSearch)
                    } header: {
                        FormSectionHeader(text: "Search options")
                    }
                    .listRowBackground(theme.theme.palette.card)
                
                    Section {
                        Picker("Columns", selection: $settings.numberOfColumns) {
                            ForEach(1...4, id: \.self) { n in
                                Text("\(n)").tag(n)
                            }
                        }
                        .pickerStyle(.segmented)
                        .accessibilityLabel("Number of columns")
                    } header: {
                        FormSectionHeader(text: "Grid layout")
                    }
                    .listRowBackground(theme.theme.palette.card)
                    
                    Section {
                        HStack(spacing: 12) {
                            ForEach(AppTheme.allCases) { t in
                                VStack {
                                    ThemeShower(theme: t, selected: theme.theme == t) {
                                        Task {
                                            theme.setTheme(t)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    Text(t.name)
                                        .font(.caption)
                                        .foregroundStyle(t.palette.text)
                                }

                            }
                        }
                        .listRowInsets(EdgeInsets())
                        .padding(.vertical, 6)
                    } header: {
                        FormSectionHeader(text: "Application Theme")
                    }
                    .listRowBackground(theme.theme.palette.card)

                    /// Liquid Glass reference:
                    /// https://developer.apple.com/documentation/SwiftUI/Applying-Liquid-Glass-to-custom-views
                    Section {
                        Toggle("Enable liquid glass", isOn: $settings.useLiquidGlass)
                    } header: {
                        FormSectionHeader(text: "Liquid Glass")
                    }
                    .listRowBackground(theme.theme.palette.card)
            }
                .scrollContentBackground(.hidden)   // iOS 16+
                .background(.clear)
                .navigationTitle("GameNEWS Settings")
            }
        
    }
}

#Preview {
   // SettingsView()
}
