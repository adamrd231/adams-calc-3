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
        GeometryReader { geo in
            VStack(alignment: .center) {
               
                ForEach(calculator.numberPadButtons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.rawValue) { item in
                            Button(action: {
                                calculator.currentInput.append(String(format: "%.0f", item.rawValue))
                            }) {
                                Text(String(format: "%.0f", item.rawValue))
                                    .font(.title)
                                    .bold()
                                    .frame(width: geo.size.width / 3 - 25, height: geo.size.height * 0.16)
                                    .foregroundColor(.white)
                                    .background(Color(.gray))
                                    .cornerRadius(35.0)
                                    .padding(1)
                                    
                            }
                        }
                    }
                }
            }
            
            .frame(width: geo.size.width)
            
        }
    }
}

struct NumberPadButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadButtonsView().environmentObject(Calculator())
    }
}
