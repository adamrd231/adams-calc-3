//
//  NumberPadButtonsView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct NumberPadButtonsView: View {
    
    @EnvironmentObject var calculator: Calculator
    
    
    var body: some View {
        ForEach(calculator.numberPadButtons, id: \.self) { row in
            HStack {
                ForEach(row, id: \.rawValue) { item in
                    Button(action: {
                        print(item.rawValue)
                        calculator.currentInput.append(String(format: "%.0f", item.rawValue))
                        print(calculator.currentInput)
                    }) {
                        Text(String(format: "%.0f", item.rawValue))
                            .padding()
                            .padding(.horizontal)
                            .background(Color(.lightGray))
                            .cornerRadius(50.0)
                            
                    }
                }
            }
        }
    }
}

struct NumberPadButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadButtonsView()
    }
}
