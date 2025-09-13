//
//  GameRequirementsSection.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameRequirementsSection: View {
    let requirements: Requirements
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("PC Requirements").font(.headline).padding(.horizontal)
            if let min = requirements.minimum?.htmlToAttributedString {
                Text(min).padding(.horizontal)
            }
            if let rec = requirements.recommended?.htmlToAttributedString {
                Text(rec).padding(.horizontal)
            }
        }
    }
}

#Preview {
   // GameRequirementsSection()
}
