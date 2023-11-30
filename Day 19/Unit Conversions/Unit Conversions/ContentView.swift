//
//  ContentView.swift
//  Unit Conversions
//
//  Created by Pascal Sauer on 30.11.23.
//

import SwiftUI

enum Temperature {
    case Celsius, Fahrenheit, Kelvin
}

let temperatureIcons: [Temperature: String] = [
    .Celsius: "C°",
    .Fahrenheit: "F°",
    .Kelvin: "K°"
]

func sortTempIcons(a: Dictionary<Temperature, String>.Element, b: Dictionary<Temperature, String>.Element) -> Bool {
    a.value < b.value
}

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool

    @State private var inputTemperature: Temperature = .Celsius
    @State private var outputTemperature: Temperature = .Fahrenheit
    @State private var inputTemperatureValue: Double = 0
    var outputTemperatureValue: Double {
        switch inputTemperature {
        case .Celsius:
            switch outputTemperature {
            case .Celsius:
                return inputTemperatureValue
            case .Fahrenheit:
                return inputTemperatureValue * 9 / 5 + 32
            case .Kelvin:
                return inputTemperatureValue + 273.15
            }
        case .Fahrenheit:
            switch outputTemperature {
            case .Celsius:
                return (inputTemperatureValue - 32) * 5 / 9
            case .Fahrenheit:
                return inputTemperatureValue
            case .Kelvin:
                return (inputTemperatureValue - 32) * 5 / 9 + 273.15
            }
        case .Kelvin:
            switch outputTemperature {
            case .Celsius:
                return inputTemperatureValue - 273.15
            case .Fahrenheit:
                return (inputTemperatureValue - 273.15) * 9 / 5 + 32
            case .Kelvin:
                return inputTemperatureValue
            }
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Temperature") {
                    Section("Input:") {
                        Picker("Einheit", selection: $inputTemperature) {
                            ForEach(temperatureIcons.sorted(by: sortTempIcons), id: \.key) {
                                Text("\($0.value)")
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        TextField("Input", value: $inputTemperatureValue, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                    
                    Section("Output:") {
                        Picker("Einheit", selection: $outputTemperature) {
                            ForEach(temperatureIcons.sorted(by: sortTempIcons), id: \.key) {
                                Text("\($0.value)")
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Text(outputTemperatureValue, format: .number)
                    }
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
