//
//  ContentView.swift
//  BetterRest
//
//  Created by Pascal Sauer on 08.12.23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeup = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var messageTitle = "Your ideal bedtime is..."
    
    var actualSleep: String {
        calculateBedtime()
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeup, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                }
                
                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                VStack {
                    Text(messageTitle)
                        .font(.headline)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                    Text(actualSleep)
                        .font(.largeTitle)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() -> String {
        var actualSleep = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeup - prediction.actualSleep
            messageTitle = "Your ideal bedtime is..."
            actualSleep = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            messageTitle = "Error"
            actualSleep = "Sorry, there was a problem calculating your bedtime"
        }
        
        return actualSleep
    }
}

#Preview {
    ContentView()
}
