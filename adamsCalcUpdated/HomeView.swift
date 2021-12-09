//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI


struct HomeView: View {
    
    @EnvironmentObject var calculator: Calculator

    var body: some View {
        GeometryReader { geo in
        VStack {
          
            // Current Operations Log
            CurrentOperationStringView()
            
            ExtraOperatorsView()
            
            OperatorButtonsView()

            // Number Pad Buttons
            NumberPadButtonsView()
            // Operator Buttons
            
            CalculateButtonView()
            
        }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Calculator())
    }
}
