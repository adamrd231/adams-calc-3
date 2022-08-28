//
//  CalculatorModel.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI
import Combine

extension Published {
    init(wrappedValue value: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
//        cancellable[key] = projectedValue.sink { val in
//            UserDefaults.standard.set(val, forKey: key)
//        }
    }
}


class Calculator: ObservableObject {
    
    @Published(key: "NumbersArray") var numbersArray:[Double] = []
    @Published(key: "OperatorsArray") var operatorsArray:[String] = []
    @Published(key: "CurrentInput") var currentInput = ""
    
    @Published(key: "CurrentOperator") var currentOperator = ""
    @Published(key: "SaveButtonOne") var saveButtonOne = ""
    @Published(key: "SaveButtonOneLocked") var saveButtonOneLocked = false
    @Published(key: "SaveButtonTwo") var saveButtonTwo = ""
    @Published(key: "SaveButtonTwoLocked") var saveButtonTwoLocked = false
    
    enum NumberPad: Double {
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        
        func getNumber() -> Double {
            return self.rawValue
        }
    }
    
    let numberPadButtons: [[NumberPad]] = [
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three],
        [.zero]
    ]

   
    enum Operator: String {
        case add = "+"
        case subtract = "-"
        case multiply = "x"
        case divide = "/"
    }
    
    enum AccessoryButtons: String {
        case clear = "A/C"
        case backspace = "<"
        case negativePostive = "+/-"
        case period = "."
    }

    let operatorButtons: [Operator] = [.add, .subtract, .multiply, .divide]
    let accessoryButtons: [AccessoryButtons] = [.period, .backspace, .negativePostive, .clear]
    
    
    func MathWithPEMDAS(arr: [Double], oper: [String]) -> Double {
        
        var result:Double = 42.0
        var array: [Double] = arr
        var operators: [String] = oper
        
        while array.count > 1 {
            // PEMDAS Math, start with multiplication and division, from left to right.
            if operators.contains("x") || operators.contains("/") {
                
                let multiplyIndex = operators.firstIndex(of: "x")
                let divisorIndex = operators.firstIndex(of: "/")
                
                if divisorIndex == nil && multiplyIndex != nil {
                    // multiply the numbers
                    let firstNumber = array.remove(at: multiplyIndex!)
                    let secondNumber = array.remove(at: multiplyIndex!)
                    result = firstNumber * secondNumber
                    array.insert(result, at: multiplyIndex!)
                    operators.remove(at: multiplyIndex!)
                    print("Multiply numbers")
                    
                }
                
                else if multiplyIndex == nil && divisorIndex != nil {
                    // dividde the numbers
                    let firstNumber = array.remove(at: divisorIndex!)
                    let secondNumber = array.remove(at: divisorIndex!)
                    result = firstNumber / secondNumber
                    array.insert(result, at: divisorIndex!)
                    operators.remove(at: divisorIndex!)
                    print("Divide numbers")
                    
                }
                
                else if multiplyIndex != nil && divisorIndex != nil {
                    // Get the first index of both and use whichever is lower
                    if multiplyIndex! < divisorIndex! {
                        let firstNumber = array.remove(at: multiplyIndex!)
                        let secondNumber = array.remove(at: multiplyIndex!)
                        result = firstNumber * secondNumber
                        array.insert(result, at: multiplyIndex!)
                        operators.remove(at: multiplyIndex!)
                        print("Multiply First")
                    } else {
                        let firstNumber = array.remove(at: divisorIndex!)
                        let secondNumber = array.remove(at: divisorIndex!)
                        result = firstNumber / secondNumber
                        array.insert(result, at: divisorIndex!)
                        operators.remove(at: divisorIndex!)
                        print("Dvivde First")
                    }
                }
                
            } else {
                let addIndex = operators.firstIndex(of: "+")
                let subtractIndex = operators.firstIndex(of: "-")
                
                if addIndex != nil && subtractIndex == nil {
                    let firstNumber = array.remove(at: addIndex!)
                    let secondNumber = array.remove(at: addIndex!)
                    result = firstNumber + secondNumber
                    array.insert(result, at: addIndex!)
                    operators.remove(at: addIndex!)
                    print("Add Numbers")
                    
                } else if addIndex == nil && subtractIndex != nil {
                    let firstNumber = array.remove(at: subtractIndex!)
                    let secondNumber = array.remove(at: subtractIndex!)
                    result = firstNumber - secondNumber
                    array.insert(result, at: subtractIndex!)
                    operators.remove(at: subtractIndex!)
                    print("Subtract Numbers")
                    
                }
                
                else if addIndex != nil && subtractIndex != nil {
                    if addIndex! < subtractIndex! {
                        let firstNumber = array.remove(at: addIndex!)
                        let secondNumber = array.remove(at: addIndex!)
                        result = firstNumber + secondNumber
                        array.insert(result, at: addIndex!)
                        operators.remove(at: addIndex!)
                        print("Add first")
                    } else {
                        let firstNumber = array.remove(at: subtractIndex!)
                        let secondNumber = array.remove(at: subtractIndex!)
                        result = firstNumber - secondNumber
                        array.insert(result, at: subtractIndex!)
                        operators.remove(at: subtractIndex!)
                        print("subtract first")
                        
                    }
                }
            }
        }
        
        return result
    }


}
