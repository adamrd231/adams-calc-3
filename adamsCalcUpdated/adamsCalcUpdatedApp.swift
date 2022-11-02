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
    
    // StoreManager object to make in-app purchases
    @StateObject var storeManager = StoreManager()
    // Advertising Product Id's
    var productIds = ["remove_advertising"]
    
    // Interstitial object for Google Ad Mobs to play video advertising
    @State var interstitial: GADInterstitialAd?
    
    #if targetEnvironment(simulator)
        // Test Ad
        var googleBannerInterstitialAdID = "ca-app-pub-3940256099942544/1033173712"
    #else
        // Real Ad
        var googleBannerInterstitialAdID = "ca-app-pub-4186253562269967/2135766372"
    #endif
    
    
    // App Tracking Transparency - Request permission and play ads on open only
    func requestIDFA() {
      ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
        // Tracking authorization completed. Start loading ads here
            
            let request = GADRequest()
                GADInterstitialAd.load(
                    withAdUnitID: googleBannerInterstitialAdID,
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


