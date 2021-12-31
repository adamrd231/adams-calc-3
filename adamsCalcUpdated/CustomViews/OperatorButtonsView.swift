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
                OperatorButton(button: button.rawValue)
            }
        }
    }
}

struct OperatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        OperatorButtonsView().environmentObject(Calculator())
    }
}
