//
//  adamsCalcUpdatedApp.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI
import AppTrackingTransparency
import GoogleMobileAds
import StoreKit

@main
struct adamsCalcUpdatedApp: App {
    
    // Model for calculator to run app
    @StateObject var calculator = Calculator()
    // StoreManager object to make in-app purchases
    @StateObject var storeManager = StoreManager()
    // Advertising Product Id's
    var productIds = ["remove_advertising"]
    
    // Interstitial object for Google Ad Mobs to play video advertising
    @State var interstitial: GADInterstitialAd?
    
    // App Tracking Transparency - Request permission and play ads on open only
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here.

        let request = GADRequest()
            GADInterstitialAd.load(
                withAdUnitID:"ca-app-pub-3940256099942544/1033173712",
                request: request,
                completionHandler: { [self] ad, error in
                    // Check if there is an error
                    if let error = error {
                        return
                    }
                    // If no errors, create an ad and serve it
                    interstitial = ad
                    let root = UIApplication.shared.windows.first?.rootViewController
                    self.interstitial!.present(fromRootViewController: root!)

                    }
                )
      })
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(storeManager: storeManager).environmentObject(calculator).onAppear(perform: {
                requestIDFA()
                SKPaymentQueue.default().add(storeManager)
                storeManager.getProducts(productIDs: productIds)
            })
        }
    }
}


