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
            
            // Add in save / reusable buttons here
            
            HStack {
                ReusableButtons(text: calculator.saveButtonOne, locked: $calculator.saveButtonOneLocked)
                ReusableButtons(text: calculator.saveButtonTwo, locked: $calculator.saveButtonTwoLocked)
                
            }
            
            .padding(.top, 5)
            .padding(.horizontal)
            
            VStack {
                ExtraOperatorsView()
                    .padding(.horizontal)
                    .padding(.bottom, 2)
                OperatorButtonsView().padding(.horizontal)
            }
            NumberPadButtonsView().padding(.horizontal, 9)
            
            CalculateButtonView()
                .padding(.horizontal)
                .padding(.top, 5)
                .padding(.bottom, 5)
            
            // Google Admob
            ZStack {
                Rectangle()
                    .frame(minWidth: 50, idealWidth: 50, maxWidth: .infinity, minHeight: 50, idealHeight: 60, maxHeight: 75)
                Text("AdMob").foregroundColor(.white)
            }
           
            
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, Color("LightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Calculator())
    }
}
