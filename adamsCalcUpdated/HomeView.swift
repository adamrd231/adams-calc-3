//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI


class HomeViewViewModel: ObservableObject {
    @StateObject var calculator = Calculator()
    
    @Published(key: "NumbersArray") var numbersArray:[String] = []
    @Published(key: "OperatorsArray") var operatorsArray:[String] = []
    @Published(key: "CurrentInput") var currentInput = ""
    @Published(key: "CurrentOperator") var currentOperator = ""

    @Published var isDisplayingFinalAnswer = false
    
    @Published var variableButtonOne = VariableButton(isLocked: false, value: "")
    @Published var variableButtonTwo = VariableButton(isLocked: false, value: "")
    
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
                numberInput(input: buttonInput)
        // Operator Buttons
        case .operation(.addition), .operation(.subtraction), .operation(.multiplication), .operation(.division): operatorInput(buttonInput)
            
        case .allClear: allClearInput()
        // Variable Buttons
        case .variable(value: variableButtonOne.value), .variable(value: variableButtonTwo.value): variableInput(buttonInput)
        case .equals: equalsButtonPressed()
        default: print("Something else")
        }
        
        // number
        // operator
        // variable
    }
    
    func updateVariableButtons() {
        // if both locked
        // do nothing
        
        // if one locked and one unlocked
        // always update unlocked
        
        // if both empty and unlocked
        // fill first
        
        // if one full and other empty both unlocked
        // fill second
        
        // if both full and both unlocked
        // replace first
        
        
        
        if !variableButtonOne.isLocked && variableButtonOne.value == "" {
            variableButtonOne.value = currentInput
        } else if !variableButtonTwo.isLocked {
            variableButtonTwo.value = currentInput
        }
    }
    
    func equalsButtonPressed() {
        numbersArray.append(currentInput)
        operatorsArray.append(currentOperator)
        currentInput = calculator.MathWithPEMDAS(arr: numbersArray, oper: operatorsArray)
        clearWorkingInputs()
        updateVariableButtons()
        isDisplayingFinalAnswer = true
        
    }
    
    func variableInput(_ input: ButtonType) {
        currentInput = input.description
    }
    
    func operatorInput(_ input: ButtonType) {

        // if operator button pressed...
        print("Pressed operator button")
        // if no inputs yet, just ignore the input
        if currentInput.isEmpty {
            return
        } else {
            currentOperator = input.description
        }

    }
    
    func numberInput(input: ButtonType) {
        
        if input == .decimal && currentInput.contains(".") {
            return
        }
        if input == .decimal && currentInput.isEmpty {
            print(currentInput.isEmpty)
            guard !currentInput.isEmpty else {
                currentInput = "0."
                return
            }
        }
        
        
        if isDisplayingFinalAnswer && currentOperator == "" {
            currentInput = input.description
            
        } else if isDisplayingFinalAnswer {
            numbersArray.append(currentInput)
            operatorsArray.append(currentOperator)
            currentOperator = ""
            currentInput = input.description
            isDisplayingFinalAnswer = false
            
        } else {
            if currentOperator == "" {
                currentInput += input.description
            } else {
                operatorsArray.append(currentOperator)
                currentOperator = ""
                numbersArray.append(currentInput)
                currentInput = input.description
            }
        }
    }
    
    func clearWorkingInputs() {
        currentOperator = ""
        numbersArray = []
        operatorsArray = []
    }
    
    func allClearInput() {
        currentInput = ""
        currentOperator = ""
        numbersArray = []
        operatorsArray = []
    }
}

struct HomeView: View {
    
    @ObservedObject var vm = HomeViewViewModel()
    @StateObject var storeManager: StoreManager
    @State var numberOfDecimals = 3
    
    

    
    var buttonTypes: [[ButtonType]] {
        [
            [.variable(value: vm.variableButtonOne.value), .variable(value: vm.variableButtonTwo.value)],
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
            ForEach(vm.numbersArray.indices, id: \.self) { index in
                Text(vm.numbersArray[index].formattedAsNumber()).foregroundColor(.yellow)
                if index < vm.operatorsArray.count {
                    Text(vm.operatorsArray[index]).foregroundColor(.red)
                }
            }
            Text(vm.currentInput.formattedAsNumber()).foregroundColor(.white)
            Text(vm.currentOperator).foregroundColor(.blue)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .font(.title)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
//        .foregroundColor(.white)
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
