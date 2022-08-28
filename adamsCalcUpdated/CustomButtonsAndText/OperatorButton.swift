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
        if calculator.saveButtonOneLocked == false {
            calculator.saveButtonOne = ""
        }
        if calculator.saveButtonTwoLocked == false {
            calculator.saveButtonTwo = ""
        }
        calculator.operatorsArray = []
        calculator.numbersArray = []
    }
    
    func pressedBackSpaceClearButton() {
        if calculator.currentInput.count > 0 && calculator.currentOperator == "" {
            calculator.currentInput.popLast()
        }
        
    }
    
    func pressedPeriodButton() {
        
        
        if calculator.currentOperator == "" {
            
            
            if calculator.currentInput == "" {
                calculator.currentInput = "0."
                return
            }
            
            if !calculator.currentInput.contains(".") && calculator.currentInput.count > 0 {
                calculator.currentInput.append(".")
                print(calculator.currentInput)
             print("does not contains a period and greater than 1")
            } else {
                print("""
                        Contains a Period.
                        Current Input: \(calculator.currentInput)
                        Count: \(calculator.currentInput.count)
                        """)
            }
            
        } else {
            let comma: Set<Character> = [","]
            calculator.currentInput.removeAll(where: {comma.contains($0)})

            calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
            calculator.operatorsArray.append(calculator.currentOperator)
            calculator.currentOperator = ""
            calculator.currentInput = "0."
        }
        
        
      
        

    }
    
    func formatNumber(number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        
        let number = NSNumber(value: number)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
    
    func pressedNegativePositiveButton() {
        if calculator.currentOperator == "" && calculator.currentInput != "" {
            let comma: Set<Character> = [","]
            calculator.currentInput.removeAll(where: {comma.contains($0)})
            var number = Double(calculator.currentInput)
            var stringNumber = number! * -1
            calculator.currentInput = formatNumber(number: stringNumber)
        }
        
        
    }
    
    var body: some View {
        
        Button(action: {
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
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color("Blue"), lineWidth: 3)
                
                if button == "+" {
                    Image(systemName: "plus").resizable().frame(width: 20, height: 20)
                } else if button == "-" {
                    Image(systemName: "minus").resizable().frame(width: 20, height: 3)

                } else if button == "x" {
                    Image(systemName: "multiply").resizable().frame(width: 18, height: 18)
                    
                } else if button == "/" {
                    Image(systemName: "divide").resizable().frame(width: 20, height: 20)
                } else {
                    Text(button).bold()
               
                }
            }
        }
        
        .frame(minWidth: 50, maxWidth: 100, minHeight: 40, idealHeight: 55, maxHeight: 75, alignment: .center)
        .foregroundColor(Color(.white))
        .background(Color("Blue"))
        .cornerRadius(25.0)
    }
}

struct OperatorButton_Previews: PreviewProvider {
    static var previews: some View {
        OperatorButton(button: "String").environmentObject(Calculator())
    }
}
