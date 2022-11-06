//
//  CalculatorViewViewModel.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 10/3/22.
//

import Foundation

struct VariableButton {
    let id: Int
    var value: String
    var isLocked: Bool
}

class CalculatorViewViewModel: ObservableObject {
    @Published var calculator = Calculator()
    @Published var storeManager = StoreManager()
    
    @Published(key: "NumbersArray") var numbersArray:[String] = []
    @Published(key: "OperatorsArray") var operatorsArray:[String] = []
    @Published(key: "CurrentInput") var currentInput = ""
    @Published(key: "CurrentOperator") var currentOperator = ""

    @Published var isDisplayingFinalAnswer = false
    
    @Published var variableButtonOne = VariableButton(id: 1, value: "", isLocked: false)
    @Published var variableButtonTwo = VariableButton(id: 2, value: "", isLocked: false)
    
    // Admob
    @Published var interstitial = AdsManager.Interstitial()
    @Published var interstitialCountdownToNextAd = 0 {
        didSet {
            print("\(interstitialCountdownToNextAd)")
            if interstitialCountdownToNextAd > 9 && storeManager.purchasedRemoveAds != true {
                print("conditions true show interstitial")
                showInterstitial = true
                interstitialCountdownToNextAd = 0
            }
        }
    }
    @Published var showInterstitial = false {
        didSet {
            if showInterstitial {
                print("Showing ad")
                interstitial.showAd()
                showInterstitial = false
            } else {
                print("Request ads")
                interstitial.requestInterstitialAds()
            }
        }
    }
    
    
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
            .digit(.zero),
            .digit(.nine):
                numberInput(input: buttonInput)
        // Operator Buttons
        case .decimal: decimalInput()
        case .operation(.addition), .operation(.subtraction), .operation(.multiplication), .operation(.division): operatorInput(buttonInput)
            
        case .allClear: allClearInput()
        case .equals: equalsButtonPressed()
        case .negative: positiveNegative()
        case .clear: singleClear()
        default: print("Something else")
        }
    }
    
    func singleClear() {
        if currentInput.contains(".") {
            if let range = currentInput.range(of: ".") {
                let digitsAfterDecimal = currentInput[range.upperBound...]
                print(digitsAfterDecimal)
                if digitsAfterDecimal == "0" {
                    currentInput.removeLast()
                    currentInput.removeLast()
                    currentInput.removeLast()
                    return
                }
            }
        }
        if currentOperator != "" {
            currentOperator = ""
        } else if currentOperator == "" && currentInput != "" {
            if currentInput.count == 2 && currentInput.contains("-") {
                currentInput.removeAll()
            } else {
                currentInput.removeLast()
            }
            if currentInput == "" {
                guard numbersArray.count > 0 else { return }
                guard operatorsArray.count > 0 else { return }
                currentInput = numbersArray.removeLast()
                currentOperator = operatorsArray.removeLast()
            }
        }
        interstitialCountdownToNextAd += 1
    }
    
    func positiveNegative() {
        guard currentInput != "" else { return }
        let inputAsDouble = (Double(currentInput) ?? 0) * -1
        currentInput = String(inputAsDouble).formattedAsNumber()
        interstitialCountdownToNextAd += 1
    }
    
    
    func updateVariableButtons() {
        // if both locked
        // do nothing
        print("one: \(variableButtonOne.isLocked) and two: \(variableButtonTwo.isLocked)")
        if variableButtonOne.isLocked && variableButtonTwo.isLocked {
            return
            
        // if one locked and one unlocked
        // always update unlocked
        } else if variableButtonOne.isLocked && !variableButtonTwo.isLocked {
            variableButtonTwo.value = currentInput
        } else if !variableButtonOne.isLocked && variableButtonTwo.isLocked {
            variableButtonOne.value = currentInput
            
            
        // if both empty and unlocked
        // fill first
        } else if !variableButtonOne.isLocked && !variableButtonTwo.isLocked {
            if variableButtonOne.value == "" {
                variableButtonOne.value = currentInput
            } else if variableButtonTwo.value == "" {
                variableButtonTwo.value = currentInput
            } else {
                variableButtonOne.value = currentInput
            }
        }
    }
    
    func clearVariableButtons() {
        if !variableButtonOne.isLocked {
            variableButtonOne.value = ""
        }
        if !variableButtonTwo.isLocked {
            variableButtonTwo.value = ""
        }
        interstitialCountdownToNextAd += 1
    }
    
    func equalsButtonPressed() {
        numbersArray.append(currentInput)
        operatorsArray.append(currentOperator)
        currentInput = calculator.MathWithPEMDAS(arr: numbersArray, oper: operatorsArray)
        clearWorkingInputs()
        updateVariableButtons()
        isDisplayingFinalAnswer = true
        interstitialCountdownToNextAd += 1
    }
    
    func variableInput(_ input: ButtonType) {
        currentInput = input.description
        interstitialCountdownToNextAd += 1
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
        interstitialCountdownToNextAd += 1
    }
    
    func decimalInput() {
        print("decimal pressed")
        if isDisplayingFinalAnswer {
            currentInput = "0."
            isDisplayingFinalAnswer = false
        }
        
        if currentOperator != "" {
            numbersArray.append(currentInput)
            operatorsArray.append(currentOperator)
            currentOperator = ""
            currentInput = "0."
            return
        }
        
        guard !currentInput.contains(".") else {
            print("Already has decimal")
            return
        }
        if currentInput != "" {
            currentInput += "."
        } else {
            currentInput = "0."
        }
        interstitialCountdownToNextAd += 1
    }
    
    
    // TODO: Handle when user presses decimal first, currently shows nothing until number input
    func numberInput(input: ButtonType) {
        if isDisplayingFinalAnswer && currentOperator == "" {
            print("here")
            currentInput = input.description
            isDisplayingFinalAnswer = false
            
        } else if isDisplayingFinalAnswer {
            print("here isDisplaying")
            numbersArray.append(currentInput)
            operatorsArray.append(currentOperator)
            currentOperator = ""
            currentInput = input.description
            isDisplayingFinalAnswer = false
            
        } else {
            if currentOperator == "" {
                print("here current operator")
                currentInput += input.description
            } else {
                print("here else")
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
        clearVariableButtons()
        interstitialCountdownToNextAd += 1
    }
}
