//
//  OnboardingView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 10/3/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var variableButton = VariableButton(id: 1, value: "42", isLocked: false)
    @State var varButton = VariableButton(id: 2, value: "24", isLocked: false)
    @State var pretendInput = "13.0"
    
    var body: some View {
        List {
            Section(header: Text("About Calculator")) {
                VStack {
                    Text("Adam's calculator is designed to help you remember, not your chores or to-do lists but the last inputs you entered. Calculating cost of internet for the year? Adam's calc saves answers from previous calculations to help, and you can use the saved answers as an input button.")
                }
            }
            
            Section(header: Text("Variable Buttons")) {
                VStack(alignment: .leading) {
                    Text(pretendInput.formattedAsNumber())
                        
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.backgroundColor)
                        .foregroundColor(Color.theme.textColor)
                        .font(.title)
                    HStack {
                        VStack {
                            Text(variableButton.value.formattedAsNumber())
                            .modifier(
                                VariableButtonStyle(size: 30, isLocked: variableButton.isLocked))
                            .onTapGesture {
                                if !variableButton.isLocked {
                                    pretendInput = variableButton.value
                                }
                                
                            }
                            .onLongPressGesture(minimumDuration: 0.3) {
                                print("Long press button one")
                                variableButton.isLocked.toggle()
                            }
                            Text(variableButton.isLocked ? "Holding Value" : "Not Holding Value")
                                .font(.subheadline)
                        }
                       
                        VStack {
                            Text(varButton.value.formattedAsNumber())
                             
                            .modifier(
                                VariableButtonStyle(size: 30, isLocked: varButton.isLocked))
                            .onTapGesture {
                                pretendInput = varButton.value
                            }
                            .onLongPressGesture(minimumDuration: 0.3) {
                                print("Long press button one")
                                varButton.isLocked.toggle()
                            }
                            Text(varButton.isLocked ? "Holding Value" : "Not Holding Value")
                                .font(.subheadline)
                        }
                    }
                    .padding(.bottom)
                   
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Press variable button to use the value in a calculation, if the var button is holding it's value it will not be replaced as new calculations are performed. If it not, one button will get replaced with each calc.")
                        Text("Long Press changes saved / not saved.")
                    }
                    .fixedSize(horizontal: false, vertical: true)
       
                }
            }
         
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
