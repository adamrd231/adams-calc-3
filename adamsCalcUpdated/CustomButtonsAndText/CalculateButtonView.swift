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
            calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
            let result = calculator.MathWithPEMDAS(arr: calculator.numbersArray, oper: calculator.operatorsArray)
            calculator.numbersArray = []
            calculator.operatorsArray = []
            print(formatNumber(number: result))
            calculator.currentInput = formatNumber(number: result)
        }
        
    }
    
    var body: some View {
        
        Button(action: {
            doMath()
        }) {
            Text("Calc")
                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 40, maxHeight: 75)
                .background(Color(.black))
                .foregroundColor(.white)
                .cornerRadius(50.0)
                .padding(.horizontal)
        }
    }
}

struct CalculateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculateButtonView().environmentObject(Calculator())
    }
}
