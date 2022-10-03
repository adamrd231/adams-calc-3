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
                        Image(systemName: "circle")
                        Text("Calc")
                    }
                }
            
            OnboardingView()
                .tabItem {
                    VStack {
                        Image(systemName: "square")
                        Text("About")
                    }
                }

            InAppStorePurchasesView(storeManager: storeManager)
                .tabItem {
                    VStack {
                        Image(systemName: "square")
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
