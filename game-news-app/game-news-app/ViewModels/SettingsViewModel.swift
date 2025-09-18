//
//  SettingsViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var usePreciseSearch: Bool
    @Published var useExactSearch: Bool
    @Published var useLiquidGlass: Bool
    let themeManager: ThemeManager
    private let settings: SettingsStore
    private var cancellables = Set<AnyCancellable>()

    init(themeManager: ThemeManager, settings: SettingsStore) {
        self.themeManager = themeManager
        self.settings = settings
        self.usePreciseSearch = settings.usePreciseSearch
        self.useExactSearch = settings.useExactSearch
        self.useLiquidGlass = settings.useLiquidGlass
        
        $usePreciseSearch.dropFirst().sink { [weak settings] in settings?.usePreciseSearch = $0 }.store(in: &cancellables)
        $useExactSearch.dropFirst().sink { [weak settings] in settings?.useExactSearch = $0 }.store(in: &cancellables)
        $useLiquidGlass.dropFirst().sink { [weak settings] in settings?.useLiquidGlass = $0 }.store(in: &cancellables)
    }
    
    func setTheme(_ theme: AppTheme) { themeManager.setTheme(theme) }
    
}
