//
//  CalculationText.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/9/21.
//

import SwiftUI

struct CalculationText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.title2)
            .bold()
    }
}

struct CalculationText_Previews: PreviewProvider {
    static var previews: some View {
        CalculationText(text: "Test")
    }
}