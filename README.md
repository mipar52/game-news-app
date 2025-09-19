# GameNEWS — iOS App
Discover, filter, and infinitely scroll video games with a modern iOS app that showcases: Swift Concurrency, MVVM, dependency injection, cursor pagination, theming, and ht iOS Liquid Glass UI.

---

- **SwiftUI-first** (iOS 16+), `NavigationStack`, `TabView`, `Form`, `Searchable`
- **MVVM** across features; **actor**-backed networking client for thread safety
- **Swift Concurrency** (`async/await`, `Task`, `CancellationError`, `@MainActor`)
- **Pagination** with RAWG’s `next` cursor, prefetch threshold & bottom sentinel, **de-dup on append**
- **Advanced search**: genres, platforms, dates, Metacritic range, ordering, page size
- **Global settings** (exact/precise search, grid columns 1–4, glass/solid bars) via `SettingsStore`
- **Theming system** (`ThemeManager` + `ThemePalette`) with multiple colorways and app-wide bar styling
- **Responsive cards** that auto-size with columns;
- **Reusable UI**: elevated button, multi-select grid chips, skeletons, error states, search prompt

---

## App Overview
**Tabs**
- **Home** — Browse game **genres** in a configurable grid → drill into a genre → **infinite game list**
- **Search** — Text search with **infinite scroll**; empty-state suggestions; **Advanced Search** screen
- **Settings** — Global filters (exact/precise), **theme picker**, **grid column count (1–4)**, **glass effect**

**Data Source** — RAWG Video Games Database API (public REST).

---

## Architecture
**Layering**
- **Views**: SwiftUI, stateless, driven by `@Published` state
- **ViewModels**: `@MainActor`, expose `LoadingState<T>`, orchestrate calls, paging, debouncing
- **Service / Client**: `GameServiceProvider` protocol; concrete **`RawgIOApiClient` (actor)**
- **Settings & Theme**: `SettingsStore` and `ThemeManager` as `ObservableObject`s injected via `@EnvironmentObject`

**Core Types**
- `LoadingState<T>` → `.idle | .loading | .loaded([T]) | .loadedSingle(T) | .failed(String)`
- `PageEnvelope<T>` → `{ count, next, previous, results }`
- `GameSearchFilters` → precise/exact/genres/platforms/dates/metacritic/ordering/pageSize with `merged(over:)`

**Dependency Injection**
- ViewModels init with `GameServiceProvider` + `SettingsStore`
- Views use wrapper inits or parent injection (avoid reading env in `init`)

---

## Networking
**Actor client** for thread safety; `URLComponents` for first page; **pass-through `next` URL** for subsequent pages to avoid duplicating page 1.

**Decoding** resilient to `null`s (`Int?`, `URL?`); custom coding keys for RAWG fields (`short_screenshots` → `shortScreenshots`).  
**Error mapping** → `NetworkError.badRequest / serverError / decode(value:) / unknown`.

---

## Search & Filters
- **Keyword search** with **debounce** (0.4–0.6s), cancellation, and infinite scroll
- **Advanced Search**: multi-select genres/platforms (generic `MultiSelectGrid<T,ID>`), date range, Metacritic range, ordering, page size
- **Global filters** from `SettingsStore` are **merged** with screen-local filters (`merged(over:)`)

---

## Theming & Bars
- `ThemeManager` with `AppTheme` cases (e.g., Classic / Neon / Mono), each providing a semantic `ThemePalette` (`header`, `text`, `card`, `background`, `accent`)
- **Consistent bars**: modifier styles both **navigation** and **tab** bars with either a **solid theme color** or **glass (material)** if enabled
- **Glass toggle** in Settings (`useLiquidGlass`) switches bars between `.ultraThinMaterial` and solid

---

## Reusable UI
- **GameListCard**: width-driven height via `.aspectRatio(16/9)`, legibility gradient, compact Metacritic badge; typography scales with column count (clamped)
- **BannerAwareGameImage**: detects ultrawide ratios and switches to **fit + blurred backdrop**
- **MultiSelectGrid** (generic): key-path driven IDs/labels, `Set<ID>` selection, adaptive/fixed layouts
- **ElevatedButton**: shadowed CTA that also works as a `NavigationLink` label
- **Skeletons & Errors**: `SkeletonGrid`, `LoadErrorView`, `ContentUnavailableView`

---

## Settings & Persistence
- `SettingsStore` (`ObservableObject`): `@Published` values for exact/precise search, `numberOfColumns` (1–4), `useLiquidGlass`, and selected theme; persisted with `UserDefaults`
- `ThemeManager`: stores the current theme; also persisted
- All views/VMs read via `@EnvironmentObject` (no singletons)

---

## Project Structure
```
GameNEWS/
├─ App/
│  ├─ GameNewsApp.swift
│  ├─ Theme/
│  │  ├─ ThemeManager.swift
│  │  └─ AppTheme.swift
│  └─ Settings/
│     ├─ SettingsStore.swift
│     └─ SettingsView.swift
├─ Features/
│  ├─ Genres/
│  │  ├─ GameGenresView.swift
│  │  ├─ GameGenreCard.swift
│  │  └─ GameGenreViewModel.swift
│  ├─ Games/
│  │  ├─ GameListView.swift
│  │  ├─ GameListViewModel.swift
│  │  ├─ GameDetailsView.swift
│  │  └─ GameDetailsViewModel.swift
│  └─ Search/
│     ├─ GameSearchView.swift
│     ├─ GameSearchViewModel.swift
│     ├─ Advanced/
│     │  ├─ GameSpecificSearchView.swift
│     │  └─ GameSpecificSearchViewModel.swift
├─ Networking/
│  ├─ RawgIOApiClient.swift
│  ├─ GameServiceProvider.swift
│  └─ Models/ (GamePreview, GameDetail, PageEnvelope, …)
├─ Shared/
│  ├─ Components/ (SearchPromptView, ElevatedButton, MultiSelectGrid, BannerAwareGameImage, SkeletonGrid, LoadErrorView, …)
│  ├─ Utils/ (LoadingState, Extensions, Deduping, ViewUtils)
│  └─ Styling/ (AppColors shim if used)
└─ Assets/
   ├─ AppIcon/
   └─ Images/ (screenshots, generated gamer icon)
```

---
