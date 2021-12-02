//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI


struct HomeView: View {
    
    @EnvironmentObject var calculator: Calculator
    

    var body: some View {
        VStack {

            // Current Operations Log
            CurrentOperationStringView().padding()
            
            // Number Pad
            ForEach(calculator.numberPadButtons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.rawValue) { item in
                        Button(action: {
                            print(item.rawValue)
                            calculator.currentInput.append(String(format: "%.0f", item.rawValue))
                            print(calculator.currentInput)
                        }) {
                            Text(String(format: "%.0f", item.rawValue))
                                .padding()
                                .padding(.horizontal)
                                .background(Color(.lightGray))
                                .cornerRadius(50.0)
                                
                        }
                    }
                }
            }
            
            HStack {
                ForEach(calculator.operatorButtons, id: \.rawValue) { button in
                    Button(action: {
                        print("Button: \(button.rawValue)")
                        
                        calculator.operatorsArray.append(button.rawValue)
                        if let currentInput = Double(calculator.currentInput) {
                            calculator.numbersArray.append(currentInput)
                            
                            print(calculator.numbersArray)
                        }
                        print("Operator Array: \(calculator.operatorsArray)")
                   
                    }) {
                        Text(button.rawValue)
                            .padding()
                            .padding(.horizontal)
                            .background(Color(.darkGray))
                            .foregroundColor(.white)
                            .cornerRadius(50.0)
                    }
                }
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Calculator())
    }
}
