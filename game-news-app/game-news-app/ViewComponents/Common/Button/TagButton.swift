//
//  TagButton.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct TagButton: View {
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
                .foregroundStyle(isSelected ? AppColors.appBackground : AppColors.appTextColor)
        }
        .font(isSelected ? .appBoldFont(size: 15) : .appSemiBoldFont(size: 15))
        .background(isSelected ? AppColors.appRed : AppColors.appHeaderText, in: Capsule())
    }
}

#Preview {
    //@Previewable @State var isSelected = false
    TagButton(text: "Horror") {
        debugPrint(">>> Tag pressed <<<")
    }
}
