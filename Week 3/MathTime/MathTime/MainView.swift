//
//  ContentView.swift
//  MathTime
//
//  Created by Roman Golub on 27.09.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject private var gameManager = GameManager()
    
    var body: some View {
        VStack {
            if gameManager.gameState == .settings {
                SettingsView(gameManager: gameManager)
            } else {
                QuestionsView(gameManager: gameManager)
            }
        }
        .background(
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .frame(width: 600, height: 900, alignment: .topTrailing)
                .clipped()
                .blur(radius: 4)
        )
    }
}

#Preview {
    MainView()
}
