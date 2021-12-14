//
//  CalculateButtonView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/9/21.
//

import SwiftUI



struct CalculateButtonView: View {
    
    @EnvironmentObject var calculator: Calculator
    
    @State var numberOfDecimals = 3
    
    func formatNumber(number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = numberOfDecimals
        
        let number = NSNumber(value: number)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
    
    func doMath() {
        if calculator.numbersArray.count != 0 && calculator.operatorsArray.count != 0 {
            
            let comma: Set<Character> = [","]
            calculator.currentInput.removeAll(where: {comma.contains($0)})
            
            calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
            let result = calculator.MathWithPEMDAS(arr: calculator.numbersArray, oper: calculator.operatorsArray)
            
            // Reset numbers and operators array to empty
            calculator.numbersArray = []
            calculator.operatorsArray = []
            calculator.currentOperator = ""
            // Save value to the result of the math operation
            calculator.currentInput = formatNumber(number: result)
            fillSavedButtons(number: result)
            
            
        }
        
    }
    
    func fillSavedButtons(number: Double) {
        if calculator.saveButtonOneLocked == false {
            calculator.saveButtonOne = formatNumber(number: number)
            print("save One")
        } else if calculator.saveButtonTwoLocked == false {
            calculator.saveButtonTwo = formatNumber(number: number)
            print("save two")
        } else {
            return
        }
    }
    
    var body: some View {
        
        Button(action: {
            doMath()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color.black, lineWidth: 3)
                Text("Calculate")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .bold()
               
            }.frame(minHeight: 35, maxHeight: 50)
            
                
                
                

      
        }
    }
}

struct CalculateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateButtonView().environmentObject(Calculator())
    }
}
