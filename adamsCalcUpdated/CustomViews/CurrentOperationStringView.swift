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
//            ForEach(calculator.numbersArray, id: \.self) { number in
//                Text(String(format: "%.2f", number))
//                if let operaand = calculator.operatorsArray[0] {
//                    Text(operaand)
//                }
//
//            }
            
            ForEach(calculator.numbersArray.indices, id: \.self) { index in
                
                Text(String(format: "%.2f", calculator.numbersArray[index]))
                Text(String(calculator.operatorsArray[index]))
                
            }
            Text(calculator.currentInput)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOperationStringView().environmentObject(Calculator())
    }
}
