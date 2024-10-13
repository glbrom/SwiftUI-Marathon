//
//  HTButton.swift
//  HabitTracking
//
//  Created by Roman Golub on 13.10.2024.
//

import SwiftUI

struct HTButton: View {
    var title: String
    var foregroundColor: Color = .white
    var background: Color = .accentColor
    var onTapGestureAction: () -> Void
    
    var body: some View {
        Text(title)
            .foregroundColor(foregroundColor)
            .frame(width: 100, height: 40)
            .background(background)
            .clipShape(Capsule())
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
            .onTapGesture {
                onTapGestureAction()
            }
    }
}
