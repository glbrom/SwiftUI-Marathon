//
//  CustomModifier.swift
//  MathTime
//
//  Created by Roman Golub on 29.09.2024.
//

import SwiftUI

struct CustomTextModifier: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(.thinMaterial)
            .background(backgroundColor)
            .cornerRadius(20)
            .shadow(color: .mint, radius: 5)
    }
}

extension View {
    func customTextStyle(backgroundColor: Color = .mint) -> some View {
        self.modifier(CustomTextModifier(backgroundColor: backgroundColor))
    }
}
