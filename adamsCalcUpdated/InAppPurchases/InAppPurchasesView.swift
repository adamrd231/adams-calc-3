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

        VStack(alignment: .leading) {
            HStack {
                Link("Privacy Policy", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                    .padding(.vertical)
                    .font(.body)
                Spacer()
                Button(action: {
                    // Restore already purchased products
                    storeManager.restoreProducts()
                }) {
                    Text("Restore Purchases")
                }
            }

            // List of Products in store
            List(self.storeManager.myProducts, id: \.self) { product in
                VStack(alignment: .leading) {
                    
                    Text("\(product.localizedTitle)").bold()
                    Text("$\(product.price)").font(.caption)
                    Text("\(product.description)").fixedSize(horizontal: false, vertical: true)
                    
                    Button( action: {
                        storeManager.purchaseProduct(product: product)
                    }) {
                        VStack {
                            if storeManager.purchasedRemoveAds == true {
                                Text("Purchased")
                            } else {
                                Text("\(product.localizedTitle)")
                                    .bold()
                                    .frame(minWidth: 50, idealWidth: .infinity, maxWidth: .infinity, minHeight: 15, idealHeight: 25, maxHeight: 35, alignment: .center)
                                    .padding()
                                    .background(Color(.systemGray))
                                    .foregroundColor(.white)
                                    .cornerRadius(15.0)
                            }
                        }
                    }.disabled(storeManager.purchasedRemoveAds)
                }
            }
            // List of Products in store
            VStack(alignment: .leading) {
                Text("Why In App Purchases?").font(.headline).bold().padding(.top)
                Text("I am an independent designer and devleoper, working on apps that help people solve problems, have fun or automate work is my goal. Purchasing an in-app purchase helps me continue to work on projects and apps.").font(.footnote)
                Text("Questions, Comments, Suggestions.").font(.subheadline).bold().padding(.top)
                Text("New feature ideas and bug fixes are always welcome at 'adam@rdconcepts.design'").font(.footnote)
                
            }
        }
        
        .padding()
    }
}

struct InAppStorePurchasesView_Previews: PreviewProvider {
    static var previews: some View {
        InAppStorePurchasesView(storeManager: StoreManager())
    }
}

