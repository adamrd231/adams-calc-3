import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var vm: CalculatorViewViewModel
    @State var isDeleting = false
    
    var body: some View {
        List {
            Section(header: Text("Clear saved calcs")) {
                VStack(alignment: .leading) {
                    Text("Reset")
                        .bold()
                    Text("This will reset all of the calculations that your app have made, this is a permanent delete.")
                    Button("Delete") {
                        isDeleting.toggle()
                    }
                    .buttonStyle(.bordered)
                }
                .alert("Are you sure?", isPresented: $isDeleting) {
                    Button("No", role: .cancel) { }
                    Button("Yes") { vm.savedEquations = [] }
                }
            }
            Section(header: Text("About the app")) {
                VStack(alignment: .leading) {
                    Text("Adam's Calc")
                        .bold()
                    Text("Designed to help you remember equations, make comparisons, and be a little more friendly than the usual calculator app. Watch the bar along the top grow as it populates any equation worth calculating, those become buttons which you can use to enter those numbers back into the mix.")
                }
            }
            Section(header: Text("About the developer")) {
                VStack(alignment: .leading) {
                    Text("rdConcepts")
                        .bold()
                    Text("Living and working out of Northern Michigan, I build iOS and websites to help solve problems for users. My goal is to work for myself using the money I raise from the apps I have developed.")
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(vm: CalculatorViewViewModel())
    }
}
