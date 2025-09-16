//
//  GameDatePicker.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct GameDatePicker: View {
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @State var hasDateChanged = false
    let onDateChange: () -> Void
    let onReset: () -> Void
    
    var body: some View {
        DatePicker("From", selection: $fromDate, displayedComponents: .date)
        DatePicker("To", selection: $toDate, displayedComponents: .date)
            .onChange(of: fromDate) {_ in
                hasDateChanged = true
                onDateChange()
                
            }
            .onChange(of: toDate) { _ in
                hasDateChanged = true
                onDateChange()
            }
        
        if (hasDateChanged) {
            Button {
                onReset()
                hasDateChanged = false
            } label: {
                Text("Clear dates")

            }

        }
    }    
}

#Preview {
  //  GameDatePicker()
}
