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
            
            HStack {
                ForEach(calculator.accessoryButtons, id: \.self) { button in
                    Button(action: {
                    }) {
                        Text(button.rawValue)
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(Color(.darkGray))
                    .foregroundColor(.white)
                    .cornerRadius(50.0)
                }
            }

            HStack {
                VStack {
                    // Number Pad Buttons
                    NumberPadButtonsView()
                }
                VStack {
                    // Operator Buttons
                    OperatorButtonsView()
                }
            }
            Button(action: {
                calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
                let result = calculator.MathWithPEMDAS(arr: calculator.numbersArray, oper: calculator.operatorsArray)
                calculator.equalsButton(number: result)
            }) {
                Text("Calc")
                    .padding()
                    .frame(minWidth: 300, maxWidth: .infinity)
                    .background(Color(.black))
                    .foregroundColor(.white)
                    .cornerRadius(50.0)
                    .padding(.horizontal)
            }
            
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Calculator())
    }
}
