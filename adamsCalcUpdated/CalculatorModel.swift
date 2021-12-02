//
//  CalculatorModel.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

class Calculator: ObservableObject {
    
    @Published var numbersArray:[Double] = []
    @Published var operatorsArray:[String] = []
    @Published var currentInput = "42"
    
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

    let operatorButtons: [Operator] = [.add, .subtract, .multiply, .divide]
    

    func MathWithPEMDAS(arr: [Double], oper: [Operator]) -> Double {
        
        var result:Double = 42.0
        var array: [Double] = arr
        var operators: [Operator] = oper
        
        while array.count > 1 {
            // PEMDAS Math, start with multiplication and division, from left to right.
            if operators.contains(.multiply) || operators.contains(.divide) {
                
                let multiplyIndex = operators.firstIndex(of: .multiply)
                let divisorIndex = operators.firstIndex(of: .divide)
                
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
                let addIndex = operators.firstIndex(of: .add)
                let subtractIndex = operators.firstIndex(of: .subtract)
                
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
