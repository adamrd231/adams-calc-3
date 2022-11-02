//
//  InAppPurchasesView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/30/21.
//

import SwiftUI


struct InAppStorePurchasesView: View {
    
    // Store Manager object for making in app purchases
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                listOfPurchases
                explanationForPurchases
            }
            .padding()
            // Navigation Components
            .navigationTitle("In-App Purchases")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Link("Privacy Policy", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Restore Purchases") {
                        storeManager.restoreProducts()
                    }
                }
            }
        }
    }
}

extension InAppStorePurchasesView {
    var listOfPurchases: some View {
        List(self.storeManager.myProducts, id: \.self) { product in
            HStack(alignment: .top, spacing: 15) {
                Image("no-ads")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .leading)
                VStack(alignment: .leading) {
                    Text("\(product.localizedTitle)")
                        .font(.subheadline)
                    Text("\(product.localizedDescription)").fixedSize(horizontal: false, vertical: true)
                        .font(.caption)
                    Button( action: {
                        storeManager.purchaseProduct(product: product)
                    }) {
                        VStack {
                            if storeManager.purchasedRemoveAds == true {
                                Text("purchased")
                            } else {
                                Text("$\(product.price)")
                                    .bold()
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    .background(Color.theme.lightGray)
                                    .foregroundColor(Color.theme.blue)
                                    .clipShape(Capsule())
                            }
                        }
                    }.disabled(storeManager.purchasedRemoveAds)
                }
            }
        }
    }
    
    var explanationForPurchases: some View {
        VStack(alignment: .leading) {
            Text("About me")
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
                .padding(.top)
                .textCase(.uppercase)
            Text("Hello, My name is Adam Reed and I am a full-time software engineer, dog-dad and believe code is where I can make my mark and help the world.")
                .font(.footnote)
            Text("How this works")
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
                .padding(.top)
                .textCase(.uppercase)
            Text("Every 10 operations the app will show an interstitial ad (video) and banner ads play at the bottom. This purchase disables all advertising.")
                .font(.footnote)
            Text("Feedback")
                .font(.subheadline)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
                .textCase(.uppercase)
                .padding(.top)
            Link("contact@rdconcepts.design", destination: URL(string: "mailto:contact@rdconcepts.design")!)
                .font(.footnote)
                .padding(.bottom)
        }
    }
}

struct InAppStorePurchasesView_Previews: PreviewProvider {
    static var previews: some View {
        InAppStorePurchasesView(storeManager: StoreManager())
    }
}

