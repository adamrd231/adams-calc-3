//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

class HomeViewViewModel: ObservableObject {
    @StateObject var calculator = Calculator()
    
    @Published(key: "NumbersArray") var numbersArray:[Double] = []
    @Published(key: "OperatorsArray") var operatorsArray:[String] = []
    @Published(key: "CurrentInput") var currentInput = ""
    @Published(key: "CurrentOperator") var currentOperator = ""

    @Published var isPerformingMath = false
    @Published var isEnteringNumber = false
    @Published var isInputingNumber = false
    
    @Published var variableButtonOne: Double = 0
    @Published var variableButtonTwo: Double = 32.2443
    
    @Published(key: "SaveButtonOne") var saveButtonOne = ""
    @Published(key: "SaveButtonOneLocked") var saveButtonOneLocked = false
    @Published(key: "SaveButtonTwo") var saveButtonTwo = ""
    @Published(key: "SaveButtonTwoLocked") var saveButtonTwoLocked = false
    
    
    func handleButtonInput(_ buttonInput: ButtonType) {
        // if user presses button with input
        // get the type of input
        switch buttonInput {
        case
            .digit(.one),
            .digit(.two),
            .digit(.three),
            .digit(.four),
            .digit(.five),
            .digit(.six),
            .digit(.seven),
            .digit(.eight),
            .digit(.nine),
            .decimal:
                updateCurrentInput(input: buttonInput)
        // Operator Buttons
        case .operation(.addition), .operation(.subtraction), .operation(.multiplication), .operation(.division): operatorInput(buttonInput)
            
        case .allClear: allClearInput()
        // Variable Buttons
        case .variable(value: variableButtonOne), .variable(value: variableButtonTwo): variableInput(buttonInput)
        default: print("Something else")
        }
        
        // number
        // operator
        // variable
    }
    
    func variableInput(_ input: ButtonType) {
        currentInput = input.description
    }
    
    func operatorInput(_ input: ButtonType) {
        // if operator button pressed...
        print("Pressed operator button")
        // if no inputs yet, just ignore the input
        guard !currentInput.isEmpty else {
            print("do nothing, no numbers")
            return
        }
        // if user has been typing in current operator,
        currentOperator = input.description
        // -> move current operator to array
        // -> clear current input,
    }
    
    func updateCurrentInput(input: ButtonType) {
        if input == .decimal && currentInput.contains(".") {
            return
        }
        if input == .decimal {
            print(currentInput.isEmpty)
            guard !currentInput.isEmpty else {
                currentInput = "0."
                return
            }
        }
        currentInput += input.description
    }
    
    func allClearInput() {
        currentInput = ""
    }
}

struct HomeView: View {
    
    @ObservedObject var vm = HomeViewViewModel()
    @StateObject var storeManager: StoreManager
    @State var numberOfDecimals = 3
    @State var finalAnswer: Double?
    

    
    var buttonTypes: [[ButtonType]] {
        [
            [.variable(value: vm.variableButtonOne), .variable(value: vm.variableButtonTwo)],
            [.allClear, .clear, .negative, .operation(.division)],
            [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiplication)],
            [.digit(.four), .digit(.five), .digit(.six), .operation(.subtraction)],
            [.digit(.one), .digit(.two), .digit(.three), .operation(.addition)],
            [.digit(.zero), .decimal, .equals]
        ]
    }
    
 
    
    @ViewBuilder var body: some View {
        VStack {
            Spacer()
            displayText
            buttonPad
        }
        .padding()
        .background(Color.black)
        
    }
}


//MARK: Views
extension HomeView {
    
    func formatNumber(number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = numberOfDecimals
        
        let number = NSNumber(value: number)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
    
    private var buttonPad: some View {
        VStack(spacing: Constants.padding) {
            ForEach(buttonTypes, id: \.self) { buttonRow in
                HStack(spacing: Constants.padding) {
                    ForEach(buttonRow, id: \.self) { buttonType in
                        CalculatorButton(buttonType: buttonType, vm: vm)
                    }
                }
            }
        }
    }
    
    private var displayText: some View {
        // Answers
        HStack {
            Text(vm.currentInput)
            Text(vm.currentOperator)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .font(.largeTitle)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
        .foregroundColor(.white)
    }
}

//MARK: Calculator Button Extensions
extension HomeView {
    struct CalculatorButton: View {
        let buttonType: ButtonType
        let vm: HomeViewViewModel
        
        var body: some View {
            Button(buttonType.description) {
                vm.handleButtonInput(buttonType)
            }
            .buttonStyle(
                CalculatorButtonStyle(
                    size: getButtonSize(),
                    backgroundColor: buttonType.backGroundColor,
                    foregroundColor: buttonType.foreGroundColor,
                    isWide: buttonType != .decimal && buttonType != .equals)
            )
        }
        
        private func getButtonSize() -> CGFloat {
            let screenWidth = UIScreen.main.bounds.width
            let buttonCount: CGFloat = 4.0
            let spacingCount = buttonCount + 1
            return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
        }
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(storeManager: StoreManager()).environmentObject(Calculator())
    }
}
