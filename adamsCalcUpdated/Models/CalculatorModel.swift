import SwiftUI
import Combine

enum Operators {
    case none
    case add
    case subtract
    case multiply
    case divide
}

class Calculator: ObservableObject {
    
    var numbersArray:[String] = []
    var operatorsArray:[String] = []
    var currentInput = ""
    var currentOperator: Operators = .none
    
    func MathWithPEMDAS(arr: [String], oper: [String]) -> String {
        var result:Double = 42.0
        var array: [Double] = arr.map { string in
            Double(string) ?? 0
        }
        var operators: [String] = oper

        while array.count > 1 {
            // PEMDAS Math, start with multiplication and division, from left to right.
            // Check if operator array contains multiplication or division
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
                    // divide the numbers
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
                    } else {
                        let firstNumber = array.remove(at: divisorIndex!)
                        let secondNumber = array.remove(at: divisorIndex!)
                        result = firstNumber / secondNumber
                        array.insert(result, at: divisorIndex!)
                        operators.remove(at: divisorIndex!)
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

                } else if addIndex == nil && subtractIndex != nil {
                    let firstNumber = array.remove(at: subtractIndex!)
                    let secondNumber = array.remove(at: subtractIndex!)
                    result = firstNumber - secondNumber
                    array.insert(result, at: subtractIndex!)
                    operators.remove(at: subtractIndex!)
                }

                else if addIndex != nil && subtractIndex != nil {
                    if addIndex! < subtractIndex! {
                        let firstNumber = array.remove(at: addIndex!)
                        let secondNumber = array.remove(at: addIndex!)
                        result = firstNumber + secondNumber
                        array.insert(result, at: addIndex!)
                        operators.remove(at: addIndex!)
                    } else {
                        let firstNumber = array.remove(at: subtractIndex!)
                        let secondNumber = array.remove(at: subtractIndex!)
                        result = firstNumber - secondNumber
                        array.insert(result, at: subtractIndex!)
                        operators.remove(at: subtractIndex!)
                    }
                }
            }
        }
        return result.description
    }


}
