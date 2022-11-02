//
//  adamsCalcUpdatedApp.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI
import AppTrackingTransparency
import StoreKit

@main
struct adamsCalcUpdatedApp: App {
    
    // StoreManager object to make in-app purchases
    @StateObject var storeManager = StoreManager()
    // Advertising Product Id's
    var productIds = ["remove_advertising"]
    
    // App Tracking Transparency - Request permission and play ads on open only
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here
      })
    }
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(storeManager: storeManager)
                .onAppear(perform: {
                    requestIDFA()
                    if storeManager.myProducts.isEmpty {
                        SKPaymentQueue.default().add(storeManager)
                        storeManager.getProducts(productIDs: productIds)
                    }
                })
        }
    }
}


