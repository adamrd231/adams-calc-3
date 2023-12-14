import Foundation

class CalculatorViewViewModel: ObservableObject {
    @Published var calculator = Calculator()
    @Published(key: "NumbersArray") var numbersArray:[String] = []
    @Published(key: "OperatorsArray") var operatorsArray:[String] = []
    @Published(key: "CurrentInput") var currentInput = ""
    @Published(key: "CurrentOperator") var currentOperator = ""

    @Published var isDisplayingFinalAnswer = false
    @Published var savedEquations: [String] = []
    
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
    }
    
    func positiveNegative() {
        guard currentInput != "" else { return }
        let inputAsDouble = (Double(currentInput) ?? 0) * -1
        currentInput = String(inputAsDouble).formattedAsNumber()
    }
    
    func equalsButtonPressed() {
        numbersArray.append(currentInput)
        operatorsArray.append(currentOperator)
        currentInput = calculator.MathWithPEMDAS(arr: numbersArray, oper: operatorsArray)
        savedEquations.append(currentInput)
        clearWorkingInputs()
        isDisplayingFinalAnswer = true
    }
    
    func variableInput(_ input: ButtonType) {
        currentInput = input.description
    }
    
    func operatorInput(_ input: ButtonType) {
        // if no inputs yet, just ignore the input
        if currentInput.isEmpty {
            return
        } else {
            currentOperator = input.description
        }
    }
    
    func decimalInput() {
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
    }
    
    // TODO: Handle when user presses decimal first, currently shows nothing until number input
    func numberInput(input: ButtonType) {
        if isDisplayingFinalAnswer && currentOperator == "" {
            currentInput = input.description
            isDisplayingFinalAnswer = false
            
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
