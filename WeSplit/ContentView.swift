//
//  ContentView.swift
//  WeSplit
//
//  Created by Niezwan Abdul Wahid on 21/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isTextFocus: Bool
    
    let currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "MYR")
    let tipPercentages = [10,15,20,25,0]
    var grandTotal: Double {
        let tipsAmount = Double(tipPercentage) / 100 * checkAmount;
        
        return tipsAmount + checkAmount
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numOfPeople + 2)
        return grandTotal / peopleCount
    }
    var body: some View {
        NavigationView { /* Needed for 1) Title above 2) New View able to slide in of current view, e.g for picker */
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($isTextFocus)
                    
                    Picker("No Of People", selection: $numOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tips", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tips")
                }
                
                Section {
                    Text(grandTotal, format: currencyCode)
                } header: {
                    Text("Grand total:")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("Amount per person: ")
                }
            }.navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isTextFocus = false
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
