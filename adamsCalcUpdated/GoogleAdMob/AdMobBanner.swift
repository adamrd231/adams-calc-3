//
//  AdMobBanner.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/22/21.
//

import SwiftUI
import GoogleMobileAds
import UIKit

final private class BannerVC: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADAdSizeBanner)
        let viewController = UIViewController()
        view.adUnitID = Constants.AdmobBannerID_TEST
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        print("Updating UIViewController")
    }
}

struct AdMobBanner: View {
    var body: some View {
        HStack(alignment: .center) {
            BannerVC().frame(width: 320, height: 55, alignment: .center)
        }
    }
}

struct AdMobBanner_Previews: PreviewProvider {
    static var previews: some View {
        AdMobBanner()
    }
}
