//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var storeManager: StoreManager
    @StateObject var vm = CalculatorViewViewModel()
    
    var body: some View {
        TabView {
            CalculatorView(
                vm: vm,
                storeManager: storeManager
            )
                .tabItem {
                    VStack {
                        Image(systemName: "plusminus.circle")
                        Text("Calc")
                    }
                }            

            OnboardingView(vm: vm)
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

