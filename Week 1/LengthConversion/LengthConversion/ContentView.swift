//
//  ContentView.swift
//  LengthConversion
//
//  Created by Roman Golub on 12.09.2024.
//

import SwiftUI

enum LengthUnit: String, CaseIterable {
    case meters = "m"
    case kilometers = "km"
    case feet = "ft"
    case yards = "yd"
    case miles = "mi"
    
    // Вычисляемый параметр, передаем значение с перечисления и возвращаем нужный UnitLength
    var unitLength: UnitLength {
        switch self {
        case .meters:
            return .meters
        case .kilometers:
            return .kilometers
        case .feet:
            return .feet
        case .yards:
            return .yards
        case .miles:
            return .miles
        }
    }
}

struct ContentView: View {
    @State private var initialUnits = 0.0
    @State private var inputUnits: LengthUnit = .meters
    @State private var outputUnits: LengthUnit = .kilometers
    @FocusState private var unitIsFocused: Bool
    
    // Передаем вводный параметр, возвращаем результат конвертации
    private var conversionResult: Double {
        let inputMeasurement = Measurement(value: initialUnits, unit: inputUnits.unitLength)
        return inputMeasurement.converted(to: outputUnits.unitLength).value
    }
    
    // Если вводной параметр совпадает с конвертируемым то подсвечиваем красным цветом
    private var resultColor: Color {
        return inputUnits == outputUnits ? .red : .primary
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Enter value") {
                    HStack {
                        TextField("Value", value: $initialUnits, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($unitIsFocused)
                        Text("\(inputUnits.rawValue)")
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Select units") {
                    Text("Input units").fontWeight(.light).font(.system(size: 16))
                    Picker("", selection: $inputUnits) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    Text("Output units").fontWeight(.light).font(.system(size: 16))
                    Picker("", selection: $outputUnits) {
                        ForEach(LengthUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                .pickerStyle(.segmented)
                .padding(5)
                
                Section("Result") {
                    Text("\(conversionResult, specifier: "%.2f") \(outputUnits.rawValue)")
                        .foregroundColor(resultColor)
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                unitIsFocused ? Button("Done") { unitIsFocused = false } : nil
            }
        }
    }
}

#Preview {
    ContentView()
}
