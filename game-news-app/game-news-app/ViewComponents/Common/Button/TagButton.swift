//
//  TagButton.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct TagButton: View {
    @EnvironmentObject var theme: ThemeManager
    @State var isSelected: Bool = false
    
    let text: String
    let onPress: () -> Void
    var body: some View {
        Button {
            isSelected.toggle()
            onPress()
        } label: {
            Text(text)
                .padding()
                .foregroundStyle(isSelected ? theme.theme.palette.header : theme.theme.palette.text)
        }
        .font(isSelected ? .appBoldFont(size: 15) : .appSemiBoldFont(size: 15))
        .background(isSelected ? theme.theme.palette.accent : theme.theme.palette.card, in: Capsule())
    }
}

#Preview {
    //@Previewable @State var isSelected = false
    TagButton(text: "Horror") {
        debugPrint(">>> Tag pressed <<<")
    }
}
