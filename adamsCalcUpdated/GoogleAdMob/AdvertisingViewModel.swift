
import SwiftUI
import GoogleMobileAds
import Combine

class AdvertisingViewModel: ObservableObject {
    
    static let shared = AdvertisingViewModel()
    @Published var interstitial = AdMobInterstitial.Interstitial()
    @Published var showedRewarded: Bool = false
    @Published var interstitialCounter = 0 {
        
        didSet {
            if interstitialCounter >= 10 {
                showInterstitial = true
                interstitialCounter = 0
            }
        }
    }
    
    @Published var showInterstitial = false {
        didSet {
            if showInterstitial {
                interstitial.showAd()
                showInterstitial = false
            } else {
                interstitial.requestInterstitialAds()
            }
        }
    }
}
