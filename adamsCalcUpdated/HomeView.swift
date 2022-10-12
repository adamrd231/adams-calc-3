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
                        Image(systemName: "plusminus")
                        Text("Calc")
                    }
                }
            
            OnboardingView()
                .tabItem {
                    VStack {
                        Image(systemName: "questionmark")
                        Text("About")
                    }
                }

            InAppStorePurchasesView(storeManager: storeManager)
                .tabItem {
                    VStack {
                        Image(systemName: "creditcard")
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
