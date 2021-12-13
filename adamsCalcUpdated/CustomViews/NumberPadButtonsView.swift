//
//  NumberPadButtonsView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct NumberPadButtonsView: View {
    
    @EnvironmentObject var calculator: Calculator

    func pressedNumberButton(number: Double) {
        // If no operator, then enter inputs into the current input variable
        if calculator.currentOperator == "" {
            calculator.currentInput.append(String(format: "%.0f", number))
        }
        
        else {
            // if there is an operator, push the operator and current Inputs to the arrays, then clear the current operator
            calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
            calculator.operatorsArray.append(calculator.currentOperator)
            calculator.currentOperator = ""
            calculator.currentInput = String(format: "%.0f", number)
        }
        

        
    }
    
    var body: some View {
        VStack(alignment: .center) {

            VStack {
                ForEach(calculator.numberPadButtons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.rawValue) { item in
                            Button(action: {
                                pressedNumberButton(number: item.rawValue)
                            }) {
                                Text(String(format: "%.0f", item.rawValue))
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                    
                                    
                            }
                            .frame(minWidth: 75, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity, alignment: .center)
                            
                            .contentShape(Rectangle())
                            .padding()
                            
                        }
                    }
                }
            }
            .background(Color(.darkGray))
            
        }
    }
}

struct NumberPadButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadButtonsView().environmentObject(Calculator())
    }
}
