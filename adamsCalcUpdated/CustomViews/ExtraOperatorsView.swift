//
//  ExtraOperatorsView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/9/21.
//

import SwiftUI

struct ExtraOperatorsView: View {
    
    @EnvironmentObject var calculator: Calculator
    
    var body: some View {
        HStack {
            ForEach(calculator.accessoryButtons, id: \.self) { button in
                Button(action: {
                }) {
                    Text(button.rawValue)
                }
                .padding()
                .padding(.horizontal)
                .background(Color(.darkGray))
                .foregroundColor(.white)
                .cornerRadius(50.0)
            }
        }
    }
}

struct ExtraOperatorsView_Previews: PreviewProvider {
    static var previews: some View {
        ExtraOperatorsView()
    }
}
