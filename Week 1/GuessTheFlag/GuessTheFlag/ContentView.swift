//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roman Golub on 10.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var questionCount = 1
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.5, blue: 0.45), location: 0.2),
                .init(color: Color(red: 0.26, green: 0.15, blue: 0.26), location: 0.5)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(30)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag \(questionCount) of 8")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 18)).bold()
                        
                        Text(countries[correctAnswer])
                            .largeBlueTitleStyle()
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flagImage: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 30))
                .shadow(radius: 20)
                
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(Color(red: 0.4, green: 0.6, blue: 0.45))
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCount != 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: restart)
            }
        } message: {
            if questionCount != 8 {
                Text("Your score is \(userScore)")
            } else {
                Text("You ended the game with a score of \(userScore). Press Restart to the new game.")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct! That's the flag of \(countries[number])"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
    }
    
    func restart() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        userScore = 0
        questionCount = 1
    }
}

// MARK: - Custom ImageView using specific set of modifiers
struct FlagImage: View {
    let flagImage: String
    
    init(flagImage: String) {
        self.flagImage = flagImage
    }
    
    var body: some View {
        Image(flagImage)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 10)
    }
}

// MARK: - Custom modifiers
struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

extension View {
    func largeBlueTitleStyle() -> some View {
        modifier(LargeBlueTitle())
    }
}

#Preview {
    ContentView()
}
