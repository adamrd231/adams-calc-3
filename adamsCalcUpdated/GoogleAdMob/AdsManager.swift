//
//  AdsManager.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 11/1/22.
//
import SwiftUI
import Combine
import GoogleMobileAds
import AppTrackingTransparency

class AdsManager: NSObject, ObservableObject {
    final class Interstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {
        private var interstitial: GADInterstitialAd?
        override init() {
            super.init()
            requestInterstitialAds()
        }
        
        func requestInterstitialAds() {
            let request = GADRequest()
            request.scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                GADInterstitialAd.load(withAdUnitID: Constants.AdmobInterstitialID, request: request, completionHandler: { [self] ad, error in
                    if let error = error {
                        print("Failed to load interstitial ad, error: \(error)")
                        return
                    }
                    interstitial = ad
                    interstitial?.fullScreenContentDelegate = self
                })
            })
        }
        
        func showAd() {
            let root = UIApplication.shared.windows.last?.rootViewController
            if let fullScreenAds = interstitial {
                fullScreenAds.present(fromRootViewController: root!)
            } else {
                print("Interstitial ad is not ready to be presented")
            }
        }
    }
}
