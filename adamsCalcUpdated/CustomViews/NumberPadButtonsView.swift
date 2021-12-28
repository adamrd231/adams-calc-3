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
        // If no operator, then enter inputs into the current input variable
        if calculator.currentOperator == "" {
            calculator.currentInput.append(String(format: "%.0f", number))
        }
        
        else {
            // if there is an operator, push the operator and current Inputs to the arrays, then clear the current operator
            let comma: Set<Character> = [","]
            calculator.currentInput.removeAll(where: {comma.contains($0)})

            calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
            calculator.operatorsArray.append(calculator.currentOperator)
            calculator.currentOperator = ""
            calculator.currentInput = String(format: "%.0f", number)
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
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .stroke(Color.black, lineWidth: 3)
                                    Text(String(format: "%.0f", item.rawValue))
                                        .font(.title)
                                        .bold()
                                        .frame(minWidth: 50, maxWidth: .infinity, minHeight: 40, maxHeight: .infinity)
                                        .cornerRadius(25)
                                        .foregroundColor(.black)
                                }
                                
                                    
                                    
                                    
                            }
                            .frame(minWidth: 75, maxWidth: .infinity, minHeight: 25, maxHeight: 75, alignment: .center)
                            
                            .padding(.horizontal, 2)
                            .padding(.vertical, 5)

                        }
                    }
                }
            }
        }
    }
}

struct NumberPadButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadButtonsView().environmentObject(Calculator())
    }
}
