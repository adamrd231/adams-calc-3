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
                    Text("\(product.localizedDescription)").fixedSize(horizontal: false, vertical: true)
                    
                    Button( action: {
                        storeManager.purchaseProduct(product: product)
                    }) {
                        VStack {
                            if storeManager.purchasedRemoveAds == true {
                                Text("Purchased")
                            } else {
                                Text("\(product.localizedTitle)")
                                    .bold()
                                    .frame(minWidth: 50, idealWidth: .infinity, maxWidth: .infinity, minHeight: 10, idealHeight: 20, maxHeight: 30, alignment: .center)
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
                Text("My day job is a software engineer, this is my side hustle. Working on problems to help people in their daily lives is my sustenance. Any money spent on in-app purchases helps me out as a developer.").font(.footnote)
                Text("Questions, Comments, Suggestions.").font(.subheadline).bold().padding(.top)
                Text("New feature ideas and bug fixes are always welcome at contact@rdconcepts.design").font(.footnote)
                
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

