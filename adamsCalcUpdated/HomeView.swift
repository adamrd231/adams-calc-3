//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

extension Published {
    init(wrappedValue value: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
//        cancellable[key] = projectedValue.sink { val in
//            UserDefaults.standard.set(val, forKey: key)
//        }
    }
}

class CalculatorViewModel: ObservableObject {
    
    @Published(key: "NumbersArray") var numbersArray:[Double] = []
    @Published(key: "OperatorsArray") var operatorsArray:[String] = []
    @Published(key: "CurrentInput") var currentInput = ""
    
    @Published(key: "CurrentOperator") var currentOperator = ""
    @Published(key: "SaveButtonOne") var saveButtonOne = ""
    @Published(key: "SaveButtonOneLocked") var saveButtonOneLocked = false
    @Published(key: "SaveButtonTwo") var saveButtonTwo = ""
    @Published(key: "SaveButtonTwoLocked") var saveButtonTwoLocked = false
    
    
    
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


struct CalculatorInputButton: Hashable {
    var id = UUID()
    var name: String
    var type: ButtonType
    var isZero: Bool
    var buttonColor: Color
    
    
    init(name: String, type: ButtonType, isZero: Bool) {
        self.name = name
        self.type = type
        switch type {
        case .number:           buttonColor = Color.theme.lightGray
        case .buttonOperator:   buttonColor = Color.theme.blue
        case .buttonFunction:   buttonColor = Color.theme.darkGray
        case .equalsButton:     buttonColor = Color.theme.blue
        case .clear:            buttonColor = Color.clear
        }
        self.isZero = isZero
        
    }
}

enum ButtonType {
    case number
    case buttonOperator
    case buttonFunction
    case equalsButton
    case clear
}

struct HomeView: View {
    
    @EnvironmentObject var calculator: Calculator
    @StateObject var storeManager: StoreManager
    
    @StateObject var vm = CalculatorViewModel()
    @State var numberOfDecimals = 3
    @State var finalAnswer:Double?
    


    var calcArray = [
        CalculatorInputButton(name: "AC", type: .buttonFunction, isZero: false),
        CalculatorInputButton(name: "+/-", type: .buttonFunction, isZero: false),
        CalculatorInputButton(name: "%", type: .buttonFunction, isZero: false),
        CalculatorInputButton(name: "/", type: .buttonOperator, isZero: false),
        
        
        CalculatorInputButton(name: "7", type: .number, isZero: false),
        CalculatorInputButton(name: "8", type: .number, isZero: false),
        CalculatorInputButton(name: "9", type: .number, isZero: false),
        CalculatorInputButton(name: "X", type: .buttonOperator, isZero: false),
        
        CalculatorInputButton(name: "4", type: .number, isZero: false),
        CalculatorInputButton(name: "5", type: .number, isZero: false),
        CalculatorInputButton(name: "6", type: .number, isZero: false),
        CalculatorInputButton(name: "-", type: .buttonOperator, isZero: false),
        
        
        CalculatorInputButton(name: "1", type: .number, isZero: false),
        CalculatorInputButton(name: "2", type: .number, isZero: false),
        CalculatorInputButton(name: "3", type: .number, isZero: false),
        CalculatorInputButton(name: "+", type: .buttonOperator, isZero: false),
        
        CalculatorInputButton(name: "0", type: .number, isZero: true),
        CalculatorInputButton(name: "", type: .clear, isZero: true),
        CalculatorInputButton(name: ".", type: .number, isZero: false),
        CalculatorInputButton(name: "=", type: .buttonOperator, isZero: false),


    ]

    var threeColumnGrid = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    
    @ViewBuilder var body: some View {
        TabView {
            GeometryReader { geo in
                VStack {
                    
                    if let answer = finalAnswer {
                        Text(answer.description)
                    } else {
                        HStack {
                            // Use a spacer to align to the right
                            Spacer()
                            
                            // Display all of the calculations and operators input thus far
                            // Start by looping through the numbers array by index
                            ForEach(vm.numbersArray.indices, id: \.self) { index in
                                
                                // Show the number inside the array based on the index
                                Text(formatNumber(number: vm.numbersArray[index]))
                                
                                // If the index is less than operators array, skip showing operator
                                if index < vm.operatorsArray.count {
                                    Text(vm.operatorsArray[index])
                                }
                            }
                            
                            // Show the current input from the user at the end of the output
                            if let doubled = Double(vm.currentInput) {
                                if vm.currentInput.last == "." {
                                    Text(vm.currentInput)
                                } else {
                                    Text(formatNumber(number: doubled))
                                }
                                
                            } else {
                                Text(vm.currentInput)
                            }
                            
                            Text(vm.currentOperator)
                                .padding(.trailing)
                        }
                            .frame(height: geo.size.height * 0.4)
                            .background(Color.gray.opacity(0.3))
                    }
                    
                        
                        
                    LazyVGrid(columns: threeColumnGrid, alignment: .center) {
                        ForEach(calcArray, id: \.id) { button in
                            Button {
                                switch button.type {
                                case .number: vm.numbersArray.append(Double(button.name) ?? 0)
                                case .buttonOperator: vm.operatorsArray.append(button.name)
                                case .buttonFunction: print("Do something")
                                case .equalsButton: finalAnswer = vm.MathWithPEMDAS(arr: vm.numbersArray, oper: vm.operatorsArray)
                                case .clear: print("do nothing")

                                }
                                
                                print("numbers array: \(vm.numbersArray.count)")
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(button.buttonColor)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: geo.size.height * 0.1, maxHeight: .infinity)
                                    Text(button.name)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(button.type == .number ? .black : .white)
                                        
                                }
                                
                            }
                        }
                    }
                    .padding()
//                    .frame(width: geo.size.width * 0.95, height: geo.size.height * 0.6)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            
            .tabItem {
                Image(systemName: "plus.rectangle").frame(width: 15, height: 15, alignment: .center)
                Text("Calculator")
            }
            

            // First Screen
            InAppStorePurchasesView(storeManager: storeManager).background(Color("dark-gray"))
            
            .tabItem {
                Image(systemName: "creditcard").frame(width: 15, height: 15, alignment: .center)
                Text("In-App Purchase")
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(storeManager: StoreManager()).environmentObject(Calculator())
    }
}


extension HomeView {
    
    func formatNumber(number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = numberOfDecimals
        
        let number = NSNumber(value: number)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
}
