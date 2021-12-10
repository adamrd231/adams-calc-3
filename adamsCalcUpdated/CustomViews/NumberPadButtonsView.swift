//
//  NumberPadButtonsView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct NumberPadButtonsView: View {
    
    @EnvironmentObject var calculator: Calculator
    

    func pressedNumberButton(number: Double) {
        if calculator.currentOperator == "" {
            calculator.currentInput.append(String(format: "%.0f", number))
        }
        
        else {
            calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
            calculator.operatorsArray.append(calculator.currentOperator)
            calculator.currentOperator = ""
            calculator.currentInput = String(number)
        }
        

        
    }
    
    var body: some View {
        VStack(alignment: .center) {

            VStack {
                ForEach(calculator.numberPadButtons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.rawValue) { item in
                            Button(action: {
                                pressedNumberButton(number: item.rawValue)
                            }) {
                                Text(String(format: "%.0f", item.rawValue))
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                    
                                    
                            }
                            .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity, alignment: .center)
                            
                        }
                    }
                }
            }
            .background(Color(.darkGray))
            
        }
    }
}

struct NumberPadButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadButtonsView().environmentObject(Calculator())
    }
}
