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

        VStack {
          
            CurrentOperationStringView()
            VStack {
                ExtraOperatorsView().padding()
                OperatorButtonsView().padding(.horizontal)
                NumberPadButtonsView().padding(.top)
            }
            
            CalculateButtonView().padding(.top)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Calculator())
    }
}
