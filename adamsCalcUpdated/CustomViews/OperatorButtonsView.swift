//
//  OperatorButtonsView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct OperatorButtonsView: View {
    
    @EnvironmentObject var calculator: Calculator
    
    var body: some View {
        VStack {
            ForEach(calculator.operatorButtons, id: \.rawValue) { button in
                Button(action: {
                    print("Button: \(button.rawValue)")
                    
                    calculator.operatorsArray.append(button.rawValue)
                    if let currentInput = Double(calculator.currentInput) {
                        calculator.numbersArray.append(currentInput)
                        calculator.currentInput = ""
                        
                        print(calculator.numbersArray)
                    }
                    print("Operator Array: \(calculator.operatorsArray)")
               
                }) {
                    Text(button.rawValue)
                        .padding()
                        .padding(.horizontal)
                        .background(Color(.darkGray))
                        .foregroundColor(.white)
                        .cornerRadius(50.0)
                }
            }
        }
    }
}

struct OperatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        OperatorButtonsView()
    }
}
