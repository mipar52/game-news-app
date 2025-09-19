//
//  SectionHeader.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title).font(.headline).padding(.horizontal)
    }
}

#Preview {
    SectionHeader(title: "Elden Ring")
}
