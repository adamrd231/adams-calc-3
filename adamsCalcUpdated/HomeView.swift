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
                        .padding(.bottom, padding)
                    OperatorButtonsView().padding(.horizontal)
                }
                NumberPadButtonsView().padding(.horizontal, 10)
                
                CalculateButtonView()
                    .padding(.horizontal)
                
                // Google Admob
                AdMobBanner()
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(
                LinearGradient(gradient: Gradient(colors: [.white, Color("LightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .tabItem {
                Image(systemName: "plus.rectangle").frame(width: 15, height: 15, alignment: .center)
                Text("Calculator")
                
            }
            
            
            
            // First Screen
            HStack {
                Text("Remove Ads")
            }
            
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
