//
//  ContentView.swift
//  BetterRest
//
//  Created by Roman Golub on 16.09.2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    // Функция, которая рассчитывает время отхода ко сну
    var calculateBedtime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Error calculating bedtime."
        }
    }
    
    // Время пробуждения по умолчанию
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Секция для выбора времени пробуждения
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                // Секция для выбора количества сна
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                // Секция с количеством чашек выпитого кофе
                Section("Daily coffee intake") {
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                // Секция с идеальным временем пробуждения
                Section {
                    Text("Your ideal bedtime is:")
                        .font(.headline)
                    Text(calculateBedtime)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
    
}

#Preview {
    ContentView()
}
