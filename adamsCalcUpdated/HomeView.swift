//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var storeManager: StoreManager
    
    
    var body: some View {
        TabView {
            CalculatorView(storeManager: storeManager)
                .tabItem {
                    VStack {
                        Image(systemName: "plusminus.circle")
                        Text("Calc")
                    }
                }            

            OnboardingView()
                .tabItem {
                    VStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("About")
                    }
                }

            InAppStorePurchasesView(storeManager: storeManager)
                .tabItem {
                    VStack(spacing: 0) {
                        Image(systemName: "creditcard.circle.fill")
                        Text("Ads")
                    }
                }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(storeManager: StoreManager())
    }
}

