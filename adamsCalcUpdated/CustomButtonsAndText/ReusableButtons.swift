//
//  ReusableButtons.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/13/21.
//

import SwiftUI

struct ReusableButtons: View {
    
    var text: String
    @Binding var locked: Bool

    @EnvironmentObject var calculator: Calculator
    
    func pressedSavedAnswerButton() {
        if calculator.currentOperator == "" {
            calculator.currentInput = text
        } else {
            
            let comma: Set<Character> = [","]
            calculator.currentInput.removeAll(where: {comma.contains($0)})

            calculator.numbersArray.append(Double(calculator.currentInput) ?? 0)
            calculator.operatorsArray.append(calculator.currentOperator)
            calculator.currentOperator = ""
            calculator.currentInput = text
            
        }
    }
        
    
    var body: some View {
        HStack {
            Button(action: {
                pressedSavedAnswerButton()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.black, lineWidth: 3)
                    Text(text)
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
            }
            .frame(minWidth: 10, idealWidth: 150, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .center)

            
            Button(action: {
                locked.toggle()
            }) {
                if locked == true {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .foregroundColor(Color(.black))
                        .frame(minWidth: 10, maxWidth: 30, minHeight: 30, maxHeight: 50, alignment: .center)
                      
                } else {
                    Image(systemName: "lock")
                        .resizable()
                        .foregroundColor(Color(.black))
                        .frame(minWidth: 10, maxWidth: 30, minHeight: 30, maxHeight: 50, alignment: .center)
                }
                
            }
            
        }
        
    }
}

