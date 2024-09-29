//
//  SettingsView.swift
//  MathTime
//
//  Created by Roman Golub on 29.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameManager: GameManager
    
    var body: some View {
        VStack {
            Text("Select tables to practice")
                .customTextStyle(backgroundColor: .mint)
                .padding(.top, 120)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(gameManager.availableTables, id: \.self) { table in
                        Button(action: {
                            if gameManager.selectedTables.contains(table) {
                                gameManager.selectedTables.remove(table)
                            } else {
                                gameManager.selectedTables.insert(table)
                            }
                        }) {
                            Text("\(table)")
                                .padding(25)
                                .font(.system(size: 19))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .background(gameManager.selectedTables.contains(table) ? Color.orange.opacity(0.8) : Color.yellow.opacity(0.8))
                                .cornerRadius(15)
                        }
                        .frame(width: 72, height: 100)
                        .padding(.top, 10)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            Text("Select number of questions")
                .customTextStyle(backgroundColor: .mint)
                .padding(.top, 40)
            
            HStack {
                ForEach(gameManager.availableQuestionCounts, id: \.self) { count in
                    Button(action: {
                        gameManager.selectedQuestions = count
                    }) {
                        Text("\(count)")
                            .padding(25)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .background(gameManager.selectedQuestions == count ? Color.orange.opacity(0.8) : Color.yellow.opacity(0.8))
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 5)
                }
            }
            .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    gameManager.generateQuestions()
                    gameManager.gameState = .inGame
                }
            }) {
                Text("Start Game")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
                    .shadow(color: .orange, radius: 3)
            }
            .padding()
        }
    }
}


#Preview {
    SettingsView(gameManager: GameManager())
}
