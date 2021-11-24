//
//  ContentView.swift
//  Shared
//
//  Created by Adam Patyk on 11/24/21.
//

import SwiftUI

struct ContentView: View {
    // PROPERTIES
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    // get currency code from device preferences
    let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    // computed property for total
    var totalAmount: Double {
        // calculate the total
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    // computed property for total per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 1) // account for list indexing
        
        // calculate the total per person
        return totalAmount / peopleCount
    }
    
    // BODY
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount",  value: $checkAmount, format: currency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1..<50) {
                            Text("\($0) \($0 < 2 ? "person" : "people")")
                        }
                    }
                } header: {
                    Text("Bill")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id:\.self) {
                            Text($0, format: .percent)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("Tip")
                }
                Section {
                    Text(totalPerPerson, format: currency)
                } header: {
                    Text("Amount Per Person")
                }
                Section {
                    Text(totalAmount, format: currency)
                } header: {
                    Text("Total")
                }
            }
            .navigationTitle("Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


// PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
