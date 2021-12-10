//
//  CalculationText.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/9/21.
//

import SwiftUI

struct CalculationText: View {
    
    var text: String
    
    var numberOfDecimals = 3
    
    func formatNumber(number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = numberOfDecimals
        
        let number = NSNumber(value: number)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
    
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.title)
            .bold()
    }
}

struct CalculationText_Previews: PreviewProvider {
    static var previews: some View {
        CalculationText(text: "Test")
    }
}
