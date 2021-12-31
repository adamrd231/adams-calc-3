//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI


struct HomeView: View {
    
    @EnvironmentObject var calculator: Calculator
    @StateObject var storeManager: StoreManager
    
    var padding: CGFloat = 2

    var body: some View {
        TabView {
            
            // First Screen
            VStack {
              
                CurrentOperationStringView()
                
                VStack {
                    // Add in save / reusable buttons here
                    
                    HStack {
                        ReusableButtons(text: calculator.saveButtonOne, locked: $calculator.saveButtonOneLocked)
                        ReusableButtons(text: calculator.saveButtonTwo, locked: $calculator.saveButtonTwoLocked)
                        
                    }

                    ExtraOperatorsView()
                        
                    HStack {
                        NumberPadButtonsView()
                        OperatorButtonsView()
                    }

                    CalculateButtonView()
                       
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.top, 2)
               
                
                // Google Admob
                AdMobBanner()
                
            }
            .background(Color("gray-color"))
            .tabItem {
                Image(systemName: "plus.rectangle").frame(width: 15, height: 15, alignment: .center)
                Text("Calculator")
            }
            

            // First Screen
            InAppStorePurchasesView(storeManager: storeManager).background(Color("dark-gray"))
            
            .tabItem {
                Image(systemName: "creditcard").frame(width: 15, height: 15, alignment: .center)
                Text("In-App Purchase")
                
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(storeManager: StoreManager()).environmentObject(Calculator())
    }
}
