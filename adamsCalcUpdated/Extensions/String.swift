//
//  String.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 9/29/22.
//

import SwiftUI

extension String {
    func formattedAsNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 3
        
        if self == "." {
            return "0."
        }
        
        
        if let number = Double(self) {
            let lastStringCharacter = self.last
            if lastStringCharacter == "." {
                let numberString = numberFormatter.string(from: NSNumber(value: number)) ?? ""
                return "\(numberString)."
            } else {
                return numberFormatter.string(from: NSNumber(value: number)) ?? ""
            }
            
        } else {
            return ""
        }
        
    }
}

