import SwiftUI

struct InAppStorePurchasesView: View {
    // Store Manager object for making in app purchases
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(storeManager.products, id: \.id) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.displayName)
                                    .bold()
                                Text(product.description)
                                    .font(.caption)
                            }
                            Spacer(minLength: 30)
                            Button(product.displayPrice) {
                                Task {
                                    try await storeManager.purchase(product)
                                }
                            }
                        }
                    }
                }
                Section {
                    explanationForPurchases
                }
            }

            // Navigation Components
            .navigationTitle("In-App Purchases")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Link("Privacy Policy", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Restore Purchases") {
                        
                    }
                }
            }
        }
    }
}

extension InAppStorePurchasesView {
    var listOfPurchases: some View {
        Text("Placeholder")
    }
    
    var explanationForPurchases: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading) {
                Text("About me")
                    .fontWeight(.bold)
                Text("Hello, My name is Adam Reed and I am a full-time software engineer, dog-dad and believe code is where I can make my mark and help the world.")
            }
            VStack(alignment: .leading) {
                Text("How this works")
                    .fontWeight(.bold)
                Text("Every 10 operations the app will show an interstitial ad (video) and banner ads play at the bottom. This purchase disables all advertising.")
            }
            VStack(alignment: .leading) {
                Text("Feedback")
                    .fontWeight(.bold)
                
                Link("contact@rdconcepts.design", destination: URL(string: "mailto:contact@rdconcepts.design")!)
   
            }
        }
    }
}

struct InAppStorePurchasesView_Previews: PreviewProvider {
    static var previews: some View {
        InAppStorePurchasesView(storeManager: StoreManager())
    }
}

