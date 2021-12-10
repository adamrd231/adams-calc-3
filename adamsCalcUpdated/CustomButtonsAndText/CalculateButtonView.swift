//
//  CalculateButtonView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/9/21.
//

import SwiftUI



struct CalculateButtonView: View {
    
    @EnvironmentObject var calculator: Calculator
    
    func doMath() {
        calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
        let result = calculator.MathWithPEMDAS(arr: calculator.numbersArray, oper: calculator.operatorsArray)
        calculator.numbersArray = []
        calculator.operatorsArray = []
        calculator.currentInput = String(result)
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
