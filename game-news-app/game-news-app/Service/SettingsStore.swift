//
//  UserDefaultsManager.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import Foundation
import SwiftUI

@MainActor
final class SettingsStore: ObservableObject {

    @Published var appTheme: AppTheme {
        didSet { UserDefaults.standard.set(appTheme.rawValue, forKey: SettingsKeys.appTheme) }
    }

    @Published var usePreciseSearch: Bool {
        didSet { UserDefaults.standard.set(usePreciseSearch, forKey: SettingsKeys.usePreciseSearch) }
    }

    @Published var useExactSearch: Bool {
        didSet { UserDefaults.standard.set(useExactSearch, forKey: SettingsKeys.useExactSearch) }
    }

    @Published var useLiquidGlass: Bool {
        didSet { UserDefaults.standard.set(useLiquidGlass, forKey: SettingsKeys.useLiquidGlass) }
    }
    
    @Published var numberOfColumns: Int {
        didSet { UserDefaults.standard.set(numberOfColumns, forKey: SettingsKeys.numOfColumns) }
    }

    init() {
        if let raw = UserDefaults.standard.string(forKey: SettingsKeys.appTheme),
           let t = AppTheme(rawValue: raw) {
            self.appTheme = t
        } else {
            self.appTheme = .classic
        }
        self.usePreciseSearch = UserDefaults.standard.object(forKey: SettingsKeys.usePreciseSearch) as? Bool ?? false
        self.useExactSearch   = UserDefaults.standard.object(forKey: SettingsKeys.useExactSearch)   as? Bool ?? false
        self.useLiquidGlass   = UserDefaults.standard.object(forKey: SettingsKeys.useLiquidGlass)   as? Bool ?? false
        self.numberOfColumns  = UserDefaults.standard.object(forKey: SettingsKeys.numOfColumns)  as? Int ?? 1
        self.numberOfColumns = max(1, min(self.numberOfColumns, 4))
    }

    var globalFilters: GameSearchFilters {
        var f = GameSearchFilters.default
        f.precise = usePreciseSearch
        f.exact = useExactSearch
        return f
    }
}
