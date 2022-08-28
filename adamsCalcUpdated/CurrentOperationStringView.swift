//
//  SwiftUIView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct CurrentOperationStringView: View {
    
    var vm: CalculatorViewModel

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
            ForEach(vm.numbersArray.indices, id: \.self) { index in
                
                // Show the number inside the array based on the index
                Text(formatNumber(number: vm.numbersArray[index]))
                
                // If the index is less than operators array, skip showing operator
                if index < vm.operatorsArray.count {
                    Text(vm.operatorsArray[index])
                }
            }
            
            // Show the current input from the user at the end of the output
            if let doubled = Double(vm.currentInput) {
                if vm.currentInput.last == "." {
                    Text(vm.currentInput)
                } else {
                    Text(formatNumber(number: doubled))
                }
                
            } else {
                Text(vm.currentInput)
            }
            
            Text(vm.currentOperator)
                .padding(.trailing)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOperationStringView(vm: CalculatorViewModel())
    }
}
