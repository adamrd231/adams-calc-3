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
            ForEach(calculator.numbersArray.indices, id: \.self) { index in
                
                Text(String(format: "%.2f", calculator.numbersArray[index]))
                
                if index < calculator.operatorsArray.count {
                    Text(String(calculator.operatorsArray[index]))
                }
            }
            Text(calculator.currentInput)
        }.frame(minWidth: 1, idealWidth: 100, maxWidth: 1000, minHeight: 1, idealHeight: 50, maxHeight: 100, alignment: .center)
        .background(Color(.gray))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentOperationStringView().environmentObject(Calculator())
    }
}
