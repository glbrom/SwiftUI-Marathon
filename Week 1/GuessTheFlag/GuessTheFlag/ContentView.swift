//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Roman Golub on 10.09.2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var questionCount = 1
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var showFlagAnimations = [Bool](repeating: false, count: 3)
    @State private var flagsNotChosen = [Bool](repeating: false, count: 3)
    
    // MARK: - Body
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
                            FlagImage(showAnimation: $showFlagAnimations[number], isNotChosen: $flagsNotChosen[number], flagImage: countries[number])
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
    
    // MARK: - Methods
    func flagTapped(_ number: Int) {
        changeFlagOpacity(tappedFlagIndex: number)
        showFlagAnimations[number].toggle()
        
        if number == correctAnswer {
            scoreTitle = "Correct! That's the flag of \(countries[number])"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
        }
        
        showingScore = true
    }
    
    func changeFlagOpacity(tappedFlagIndex: Int) {
        for index in 0..<flagsNotChosen.count {
            // Set the flag to true, if the index does not match the selected one
            flagsNotChosen[index] = index != tappedFlagIndex
        }
    }
    
    func askQuestion() {
        flagsNotChosen = [Bool](repeating: false, count: 3)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
    }
    
    func restart() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        userScore = 0
        questionCount = 1
        flagsNotChosen = [Bool](repeating: false, count: 3)
    }
}

// MARK: - Custom ImageView using specific set of modifiers + animation
struct FlagImage: View {
    @Binding var showAnimation: Bool
    @Binding var isNotChosen: Bool
    let flagImage: String
    
    var body: some View {
        Image(flagImage)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 10)
            .opacity(isNotChosen ? 0.25 : 1)
            .scaleEffect(isNotChosen ? 0.8 : 1)
            .blur(radius: isNotChosen ? 4 : 0)
        //            .rotation3DEffect(.degrees(isNotChosen ? 360 : 0), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(showAnimation ? 360 : 0), axis: (x: 0, y: 1, z: 0))
            .animation(.spring(duration: 2, bounce: 0.5), value: showAnimation)
            .animation(.default, value: isNotChosen)
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
