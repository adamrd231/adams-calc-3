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
    @Published var calculator = Calculator()

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
        case .variable:         buttonColor = Color.blue
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
    case variable
    case clear
}

struct HomeView: View {
    
    @EnvironmentObject var calculator: Calculator
    @StateObject var storeManager: StoreManager
    
    @StateObject var vm = CalculatorViewModel()
    @State var numberOfDecimals = 3
    @State var finalAnswer:Double?
    
    var savedArray = [
        CalculatorInputButton(name: "Var", type: .variable, isZero: false),
        CalculatorInputButton(name: "Var", type: .variable, isZero: false),
        CalculatorInputButton(name: "Var", type: .variable, isZero: false),
        CalculatorInputButton(name: "Var", type: .variable, isZero: false),
    ]

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
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15),
    ]

    
    @ViewBuilder var body: some View {
        TabView {
            GeometryReader { geo in
                VStack {
        
                    // Answers
                    ZStack(alignment: .bottomTrailing) {
                        Rectangle()
                            .fill(Color.theme.lightGray)
                            .frame(width: geo.size.width, height: geo.size.height * 0.33)
                        VStack {
                            ForEach(savedArray, id: \.self) { savedAnswer in
                                Text(savedAnswer.name)
                            }
                            Text("28 + 5")
                                .font(.largeTitle)
                                .padding()
                        }
                        
                    }
                        
                    LazyVGrid(columns: threeColumnGrid, alignment: .center, spacing: 10) {
                        ForEach(calcArray, id: \.id) { button in
                            Button {
                                switch button.type {
                                case .number: vm.calculator.numbersArray.append(Double(button.name) ?? 0)
                                case .buttonOperator: vm.calculator.operatorsArray.append(button.name)
                                case .buttonFunction: print("Do something")
                                case .variable: print("use variable")
                                case .equalsButton: finalAnswer = vm.calculator.MathWithPEMDAS(arr: vm.calculator.numbersArray, oper: vm.calculator.operatorsArray)
                                case .clear: print("do nothing")

                                }
                                
                                print("numbers array: \(vm.calculator.numbersArray.count)")
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
                    .padding(.top)
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
