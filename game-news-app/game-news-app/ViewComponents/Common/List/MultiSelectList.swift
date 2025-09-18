//
//  MultiSelectList.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct MultiSelectGrid<T, ID: Hashable>: View {
    let allItems: [T]
    @Binding var selectedIDs: Set<ID>
    let id: KeyPath<T, ID>
    let label: KeyPath<T, String>
    private let minChipWidth: CGFloat
    private let spacing: CGFloat
    private let numOfColumns: Int
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: spacing), count: numOfColumns)
    }
    
    init(
        allItems: [T],
        selectedIDs: Binding<Set<ID>>,
        id: KeyPath<T, ID>,
        label: KeyPath<T, String>,
        minChipWidth: CGFloat = 120,
        spacing: CGFloat = 8,
        numsOfColumns: Int = 3
    ) {
        self.allItems = allItems
        self._selectedIDs = selectedIDs
        self.id = id
        self.label = label
        self.minChipWidth = minChipWidth
        self.spacing = spacing
        self.numOfColumns = numsOfColumns
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns, spacing: 8) {
                ForEach(allItems, id: id) { item in
                    let isOn = selectedIDs.contains(item[keyPath: id])
                    SelectableTag(
                        title: item[keyPath: label],
                        selected: isOn
                    ) {
                        let key = item[keyPath: id]
                        if isOn { selectedIDs.remove(key) } else { selectedIDs.insert(key) }
                    }
                }
            }
        }
    }
}

/// Small pill-style tag that reflects selection state.
struct SelectableTag: View {
    @EnvironmentObject var theme: ThemeManager
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.appBoldFont(size: 15))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundStyle(selected ? theme.theme.palette.header: theme.theme.palette.text)
        }
        .buttonStyle(.plain)
        .background(
            (selected ? theme.theme.palette.accent : theme.theme.palette.background),
            in: Capsule()
        )
        .contentShape(Capsule())
      //  .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

#Preview {
//    @Previewable @State var selectedItem: Array<GameGenre> = []
//    MultiSelectList<GameGenre>(allItems:
//                        [GameGenre(id: 0, name: "Horror", slug: "horror", gamesCount: 10000, imageBackground: "jpg"),
//                         GameGenre(id: 1, name: "First person shooter (FPS)", slug: "fps", gamesCount: 10000, imageBackground: "jpg"),
//                         GameGenre(id: 2, name: "Horror", slug: "horror", gamesCount: 10000, imageBackground: "jpg"),
//                          GameGenre(id: 3, name: "First person shooter (FPS)", slug: "fps", gamesCount: 10000, imageBackground: "jpg"),
//                         GameGenre(id: 4, name: "Horror", slug: "horror", gamesCount: 10000, imageBackground: "jpg"),
//                          GameGenre(id: 5, name: "First person shooter (FPS)", slug: "fps", gamesCount: 10000, imageBackground: "jpg")
//                        ], selectedItems: $selectedItem)
}
