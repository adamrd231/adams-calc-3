//
//  SwiftUIView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct CurrentOperationStringView: View {
    
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
    
    func addCommasToString(string: String) -> String {
        
        let stringLength = string.count
        var newString = string
        
        if stringLength == 3 {
            newString.append(",")
            calculator.currentInput = newString
            return newString
        } else if stringLength == 7 {
            newString.append(",")
            calculator.currentInput = newString
            return newString
        } else if stringLength == 11 {
            newString.append(",")
            calculator.currentInput = newString
            return newString
        } else if stringLength == 15 {
            newString.append(",")
            calculator.currentInput = newString
            return newString
        } else if stringLength == 19 {
            newString.append(",")
            calculator.currentInput = newString
            return newString
        } else if stringLength == 23 {
            newString.append(",")
            calculator.currentInput = newString
            return newString
        } else {
            return string
        }
        

    }
    
    
    var body: some View {
        HStack {
            // Use a spacer to align to the right
            Spacer()
            
            // Display all of the calculations and operators input thus far
            // Start by looping through the numbers array by index
            ForEach(calculator.numbersArray.indices, id: \.self) { index in
                
                // Show the number inside the array based on the index
                CalculationText(text: formatNumber(number: calculator.numbersArray[index]))
                
                // If the index is less than operators array, skip showing operator
                if index < calculator.operatorsArray.count {
                    CalculationText(text: calculator.operatorsArray[index])
                }
            }
            
            // Show the current input from the user at the end of the output
            CalculationText(text: addCommasToString(string: calculator.currentInput))
            
            
            CalculationText(text: calculator.currentOperator)
                .padding(.trailing)
        }
        .frame(minHeight: 75, maxHeight: 140)
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, Color(.darkGray)]), startPoint: .topTrailing, endPoint: .bottomLeading))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOperationStringView().environmentObject(Calculator())
    }
}
