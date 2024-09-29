//
//  GameManager.swift
//  MathTime
//
//  Created by Roman Golub on 29.09.2024.
//

import SwiftUI

enum GameState {
    case settings
    case inGame
}

class GameManager: ObservableObject {
    @Published var selectedTables = Set<Int>()
    @Published var selectedQuestions = 5
    @Published var questions: [(String, Int)] = []
    @Published var userAnswers: [String] = []
    @Published var answerStatus: [Bool] = []
    @Published var showResults = false
    @Published var gameState: GameState = .settings
    
    let availableTables = Array(1...12)
    let availableQuestionCounts = [5, 10, 20]
    
    func generateQuestions() {
        questions.removeAll()
        userAnswers.removeAll()
        answerStatus.removeAll()
        
        for _ in 0..<selectedQuestions {
            let table = selectedTables.randomElement() ?? 2
            let multiplier = Int.random(in: 1...12)
            let question = "\(table) x \(multiplier)"
            questions.append((question, table * multiplier))
            userAnswers.append("")
            answerStatus.append(true)
        }
    }
    
    func checkAnswers() {
        for i in 0..<questions.count {
            if userAnswers[i].isEmpty || (Int(userAnswers[i]) != nil && Int(userAnswers[i]) != questions[i].1) {
                answerStatus[i] = false
            }
        }
        showResults = true
    }
    
    func calculateScore() -> Int {
        guard !questions.isEmpty else { return 0 }
        let correctCount = answerStatus.filter { $0 }.count
        return Int(Double(correctCount) / Double(questions.count) * 100)
    }
    
    func restart() {
        selectedTables.removeAll()
        selectedQuestions = 5
        questions.removeAll()
        userAnswers.removeAll()
        answerStatus.removeAll()
        showResults = false
        gameState = .settings
    }
}
