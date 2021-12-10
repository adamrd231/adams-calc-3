//
//  SwiftUIView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct CurrentOperationStringView: View {
    
    @EnvironmentObject var calculator: Calculator

    func printIndex() {
        
    }
    var body: some View {
        HStack {
            // Use a spacer to align to the right
            Spacer()
            
            // Display all of the calculations and operators input thus far
            // Start by looping through the numbers array by index
            ForEach(calculator.numbersArray.indices, id: \.self) { index in
                
                // Show the number inside the array based on the index
                CalculationText(text: String(format: "%.2f", calculator.numbersArray[index]))
                
                // If the index is less than operators array, skip showing operator
                if index < calculator.operatorsArray.count {
                    CalculationText(text: calculator.operatorsArray[index])
                }
            }
            
            // Show the current input from the user at the end of the output
            CalculationText(text: calculator.currentInput)
            CalculationText(text: calculator.currentOperator).padding(.trailing)

        }.frame(minHeight: 100, maxHeight: 125)
        .background(Color(.lightGray))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOperationStringView().environmentObject(Calculator())
    }
}
