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
            CalculationText(text: calculator.currentInput)
            
            
            CalculationText(text: calculator.currentOperator)
                .padding(.trailing)
        }
        .frame(minHeight: 75, maxHeight: 140)
        .background(Color(.darkGray))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOperationStringView().environmentObject(Calculator())
    }
}
