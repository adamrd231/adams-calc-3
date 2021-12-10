//
//  OperatorButton.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/9/21.
//

import SwiftUI

struct OperatorButton: View {
    
    @EnvironmentObject var calculator: Calculator
    @State var button: String
    
    func pressedOperator(newOperator: String) {
        // If no number entry yet, wait to use operators
        if calculator.currentInput == "" {
            print("Current input empty, can not add operator now")
        }
        
        // No operator, go ahead and enter that bad boi!
        else  {
            print("Update the operator with a new operator")
            // Append the operator button
            calculator.currentOperator = newOperator
          
        }
    }
    
    func pressedClearButton() {
        calculator.currentInput = ""
        calculator.currentOperator = ""
        calculator.operatorsArray = []
        calculator.numbersArray = []
    }
    
    func pressedBackSpaceClearButton() {
        if calculator.currentInput.count >= 1 && calculator.currentOperator == "" {
            calculator.currentInput.popLast()
        }
        
    }
    
    func pressedPeriodButton() {
        if !calculator.currentInput.contains(".") && calculator.currentInput.count > 0 {
            calculator.currentInput.append(".")
        }
        

    }
    
    func pressedNegativePositiveButton() {
        if calculator.currentOperator == "" {
            var number = Double(calculator.currentInput)
            var stringNumber = String(number! * -1)
            calculator.currentInput = stringNumber
        }
        
        
    }
    
    var body: some View {
        
        Button(button) {
            switch button {
            case ".": pressedPeriodButton()
            case "<": pressedBackSpaceClearButton()
            case "+/-": pressedNegativePositiveButton()
            case "A/C": pressedClearButton()
            case "+": pressedOperator(newOperator: button)
            case "-": pressedOperator(newOperator: button)
            case "x": pressedOperator(newOperator: button)
            case "/": pressedOperator(newOperator: button)
            
            
            default: print("Didnt press anything I expected")
            }
            
            
        }
        .font(.title3)
        .frame(minWidth: 10, idealWidth: 150, maxWidth: .infinity, minHeight: 40, maxHeight: 60, alignment: .center)
        .foregroundColor(.white)
        .background(Color(.darkGray))
        .cornerRadius(25.0)
    }
}

struct OperatorButton_Previews: PreviewProvider {
    static var previews: some View {
        OperatorButton(button: "String").environmentObject(Calculator())
    }
}