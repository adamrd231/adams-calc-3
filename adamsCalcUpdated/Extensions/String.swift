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
        
        if let number = Double(self) {
            return numberFormatter.string(from: NSNumber(value: number)) ?? ""
        } else {
            return ""
        }
        
    }
}

