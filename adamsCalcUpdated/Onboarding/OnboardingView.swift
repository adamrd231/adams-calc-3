//
//  OnboardingView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 10/3/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var variableButton = VariableButton(id: 1, value: "42", isLocked: false)
    @State var pretendInput = ""
    
    var body: some View {
        List {
            Section(header: Text("WTF is this all about?")) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("The big idea")
                        .font(.headline)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                    Text("Adam's calculator is designed to help you remember, not your chores or to-do lists but the last inputs you entered. Calculating cost of internet for the year? Adam's calc saves answers from previous calculations to help, and you can use the saved answers as an input button.")
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 5)
            }
            
            Section(header: Text("Variable Button Demo")) {
                VStack(alignment: .center) {
                    Text(pretendInput.formattedAsNumber())
                        .fontWeight(.heavy)
                        .frame(height: 100)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 15)
                        .foregroundColor(Color.theme.textColor)
                        .font(.largeTitle)
   
                    VStack {
                        Text(variableButton.value.formattedAsNumber())
                        .modifier(
                            VariableButtonStyle(size: (100, 50), isLocked: variableButton.isLocked))
                        
                        .onTapGesture {
                            pretendInput = variableButton.value
                        }
                        .onLongPressGesture(minimumDuration: 0.3) {
                            print("Long press button one")
                            variableButton.isLocked.toggle()
                        }
                        Text(variableButton.isLocked ? "Saving Value" : "Not Saving Value")
                            .font(.subheadline)
                    }
                    .padding(.bottom)
     
                    HStack {
                        Button("9 * 6") {
                            pretendInput = "54"
                            if !variableButton.isLocked {
                                variableButton.value = "54"
                            }
                        }
                        .buttonStyle(.plain)
                        .padding()
                        .background(Color(.lightGray))
                        .cornerRadius(15)

                        Button("6 * 7") {
                            pretendInput = "42"
                            if !variableButton.isLocked {
                                variableButton.value = "42"
                            }
                        }
                        .buttonStyle(.plain)
                        .padding()
                        .background(Color(.lightGray))
                        .cornerRadius(15)
                        Button("5 * 3") {
                            pretendInput = "15"
                            if !variableButton.isLocked {
                                variableButton.value = "15"
                            }
                        }
                        .buttonStyle(.plain)
                        .padding()
                        .background(Color(.lightGray))
                        .cornerRadius(15)
                    }
                    Text("Demo calculations for demonstration")
                        .font(.subheadline)
                    
                   
                    VStack(alignment: .leading, spacing: 9) {
                        Text("Short Press • Use number in field as input")
                        Text("Long Press • changes button status to saved or not saving number")
                        Text("• Saved variable button does not accept new inputs")
                        
                    }
                    .font(.headline)
                    .padding(.vertical)
                    .fixedSize(horizontal: false, vertical: true)
                    Text("Feedback welcome at contact@rdconcepts.design")
                        .font(.caption)
                        .padding(.bottom)
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
