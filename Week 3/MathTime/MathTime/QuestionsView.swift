//
//  QuestionsView.swift
//  MathTime
//
//  Created by Roman Golub on 29.09.2024.
//

import SwiftUI

struct QuestionsView: View {
    @ObservedObject var gameManager: GameManager
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(0..<gameManager.questions.count, id: \.self) { index in
                        HStack {
                            ResultField(
                                title: "\(gameManager.questions[index].0) = ",
                                text: $gameManager.userAnswers[index],
                                backgroundColor: gameManager.answerStatus[index] ? Color.clear : Color.red.opacity(0.2)
                            )
                        }
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.top, 10)
                    }
                    
                    if !gameManager.showResults {
                        Button(action: {
                            withAnimation {
                                gameManager.checkAnswers()
                            }
                        }) {
                            Text("Submit Answers")
                                .font(.headline)
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
            
            if gameManager.showResults {
                let score = gameManager.calculateScore()
                Text("Score: \(score)%")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(10)
                    .shadow(color: .mint, radius: 3)
                    .padding(.bottom, 50)
                
                Button(action: {
                    withAnimation {
                        gameManager.restart()
                    }
                }) {
                    Text("Restart")
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
}

struct ResultField: View {
    let title: String
    @Binding var text: String
    @FocusState var isTyping: Bool
    
    var backgroundColor: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            TextField("", text: $text)
                .padding(.leading)
                .frame(height: 50)
                .focused($isTyping)
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isTyping ? .mint : .yellow, lineWidth: 2)
                )
            
            Text(title).padding(.horizontal, 4)
                .keyboardType(.numberPad)
                .background(.mint.opacity(isTyping || !text.isEmpty ? 1 : 0), in: RoundedRectangle(cornerRadius: 5))
                .foregroundStyle(isTyping ? .white : .black)
                .padding(.leading).offset(y: isTyping || !text.isEmpty ? -27 : 0)
                .onTapGesture {
                    isTyping.toggle()
                }
        }
        .animation(.linear(duration: 0.2), value: isTyping)
    }
}

#Preview {
    QuestionsView(gameManager: GameManager())
}
