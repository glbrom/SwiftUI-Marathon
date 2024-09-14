//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Roman Golub on 13.09.2024.
//

import SwiftUI

enum Choice: String, CaseIterable {
    case rock = "👊🏻"
    case paper = "✋🏻"
    case scissors = "✌🏻"
    
    // Метод для определения выигрыша
    func winningMoves (item beats: Choice) -> Bool {
        switch (self, beats) {
        case (.paper, .rock), (.rock, .scissors), (.scissors, .paper):
            return true
        default:
            return false
        }
    }
}

struct ContentView: View {
    @State private var computerChoice: Choice? = .rock
    @State private var scorePoint = 0
    @State private var currentRound = 0
    @State private var resultMessage = ""
    @State private var shouldWinOrLose = true
    @State private var gameOver = false
    @State private var showingResult = false
    
    private let gameOverAfterRounds = 10
    
    // Логика одного хода
    private func oneMove(_ playerChoice: Choice) {
        computerChoice = Choice.allCases.randomElement()
        
        // Есть ли ничья
        if playerChoice == computerChoice {
            updateScoreAndMessage(isCorrect: nil, playerChoice: playerChoice, computerChoice: computerChoice!)
        } else {
            // Определяем, выиграл ли игрок
            let playerWins = playerChoice.winningMoves(item: computerChoice!)
            let isCorrect = (shouldWinOrLose && playerWins) || (!shouldWinOrLose && !playerWins)
            // Обновляем счёт и сообщение
            updateScoreAndMessage(isCorrect: isCorrect, playerChoice: playerChoice, computerChoice: computerChoice!)
        }
        
        showingResult = true
    }
    
    // Обновление счета и сообщения в зависимости от результата
    private func updateScoreAndMessage(isCorrect: Bool?, playerChoice: Choice, computerChoice: Choice) {
        currentRound += 1
        
        // Проверка результата раунда
        if let isCorrect = isCorrect {
            if isCorrect {
                scorePoint += 1
                resultMessage = "You won!\n\(playerChoice.rawValue) VS \(computerChoice.rawValue)"
            } else {
                resultMessage = "Computer won!\n\(playerChoice.rawValue) VS \(computerChoice.rawValue)"
            }
        } else {
            resultMessage = "It's a draw!\n\(playerChoice.rawValue) VS \(computerChoice.rawValue)"
        }
    }
    
    private func nextRound() {
        gameOver = currentRound >= gameOverAfterRounds ? true : false
    }
    
    private func resetGame() {
        scorePoint = 0
        currentRound = 0
        computerChoice = Choice.allCases.randomElement()!
        gameOver = false
        showingResult = false
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.7, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.1, green: 0.35, blue: 0.36), location: 0.3)
            ], center: .top, startRadius: 820, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.regularMaterial)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Round \(currentRound) of \(gameOverAfterRounds)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 22)).bold()
                        
                        if let compChoice = computerChoice {
                            Text("\(compChoice.rawValue)")
                                .font(.system(size: 150))
                        }
                    }
                    
                    HStack {
                        ForEach(Choice.allCases, id: \.self) { emoji in
                            Button(action: {
                                oneMove(emoji)
                            }) {
                                Text(emoji.rawValue)
                                    .font(.system(size: 40))
                                    .padding()
                                    .background(Color(red: 0.3, green: 0.7, blue: 0.4))
                                    .cornerRadius(20)
                            }
                            .shadow(radius: 5)
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Button(action: {
                    resetGame()
                }) {
                    Text("New game")
                        .font(.system(size: 20)).bold()
                        .foregroundStyle(.ultraThickMaterial)
                        .padding()
                        .background(Color(red: 0.3, green: 0.7, blue: 0.4))
                        .cornerRadius(20)
                }
                Spacer()
                
                Text("Win: \(scorePoint)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                    .padding()
            }
            .padding()
        }
        // Показываем результат после каждого хода
        .alert(resultMessage, isPresented: $showingResult) {
            Button("Next round", action: nextRound)
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("New game", action: resetGame)
        } message: {
            Text("Your final score is \(scorePoint).")
        }
    }
}

#Preview {
    ContentView()
}
