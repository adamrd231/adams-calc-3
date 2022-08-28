//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI


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
        case .clear:            buttonColor = Color.clear
        }
        self.isZero = isZero
        
    }
}

enum ButtonType {
    case number
    case buttonOperator
    case buttonFunction
    case clear
}

struct HomeView: View {
    
    @EnvironmentObject var calculator: Calculator
    @StateObject var storeManager: StoreManager


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

    
    var body: some View {
        TabView {
            GeometryReader { geo in
                VStack {
                    CurrentOperationStringView()
                        .frame(height: geo.size.height * 0.4)
                        .background(Color.gray.opacity(0.3))
                        
                        
                    LazyVGrid(columns: threeColumnGrid, alignment: .center) {
                        ForEach(calcArray, id: \.id) { button in
               
                            Button {
                                
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
