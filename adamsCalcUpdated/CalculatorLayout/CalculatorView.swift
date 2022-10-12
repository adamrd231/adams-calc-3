//
//  CalculatorView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 10/3/22.
//

import SwiftUI

struct CalculatorView: View {
    @ObservedObject var vm = CalculatorViewViewModel()
    @StateObject var storeManager: StoreManager
    @State var numberOfDecimals = 3
    
    var buttonTypes: [[ButtonType]] {
        [
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
        .background(Color.theme.backgroundColor)
    }
}

//MARK: Views
extension CalculatorView {
    
    private var buttonPad: some View {

        VStack(spacing: Constants.padding) {
            
            VariableButton(vm: vm, function: getButtonSize)
            
            .foregroundColor(.white)
            ForEach(buttonTypes, id: \.self) { buttonRow in
                HStack(spacing: Constants.padding) {
                    ForEach(buttonRow, id: \.self) { buttonType in
                        CalculatorButton(buttonType: buttonType, vm: vm, function: getButtonSize)
                    }
                }
            }
        }
    }
    
    private var displayText: some View {
        // Answers
        VStack {
            HStack {
                ForEach(vm.numbersArray.indices, id: \.self) { index in
                    Text(vm.numbersArray[index].formattedAsNumber())
                    if index < vm.operatorsArray.count {
                        Text(vm.operatorsArray[index])
                    }
                }
                Text(vm.currentInput.formattedAsNumber())
                Text(vm.currentOperator)
                   
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .font(.system(size: 50))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
        }
        .foregroundColor(Color.theme.textColor)
    }
}

//MARK: Calculator Button Extensions
extension CalculatorView {
    
    func getButtonSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let buttonCount: CGFloat = 4.0
        let spacingCount = buttonCount + 1
        return (screenWidth - (spacingCount * Constants.padding)) / buttonCount
    }
    
    struct VariableButton: View {

        let vm: CalculatorViewViewModel
        var function: () -> CGFloat
        
        
        func handleVariableButtonInput(button: Int) {
            
            if vm.currentOperator != "" {
                vm.operatorsArray.append(vm.currentOperator)
                vm.numbersArray.append(vm.currentInput)
                vm.currentOperator = ""
                switch button {
                case 1: vm.currentInput = vm.variableButtonOne.value
                case 2: vm.currentInput = vm.variableButtonTwo.value
                default: print("You messed up homie")
                }
                
            } else {
                switch button {
                case 1: vm.currentInput = vm.variableButtonOne.value
                case 2: vm.currentInput = vm.variableButtonTwo.value
                default: print("You messed up homie")
                }
            }
            
            vm.isDisplayingFinalAnswer = true
           
        }
        
        var body: some View {
            HStack {
                
                Text(vm.variableButtonOne.value.formattedAsNumber())
                .modifier(
                    VariableButtonStyle(size: self.function(), isLocked: vm.variableButtonOne.isLocked))
                .onTapGesture {
                    print("short press button one")
                    handleVariableButtonInput(button: 1)
                }
                .onLongPressGesture(minimumDuration: 0.3) {
                    print("Long press button one")
                    vm.variableButtonOne.isLocked.toggle()
                }
                
                Text(vm.variableButtonTwo.value.formattedAsNumber())
                .modifier(
                    VariableButtonStyle(size: self.function(), isLocked: vm.variableButtonTwo.isLocked))
                .onTapGesture {
                    print("short press button two")
                    handleVariableButtonInput(button: 2)
                }
                .onLongPressGesture(minimumDuration: 0.3) {
                    print("Long press button two")
                    vm.variableButtonTwo.isLocked.toggle()
                }
            }
           
        }
    }
    
    struct CalculatorButton: View {
        let buttonType: ButtonType
        let vm: CalculatorViewViewModel
        var function: () -> CGFloat
        
        var body: some View {
        
            Button(buttonType.description) {
                vm.handleButtonInput(buttonType)
            }
            .buttonStyle(
                CalculatorButtonStyle(
                    size: self.function(),
                    backgroundColor: buttonType.backGroundColor,
                    foregroundColor: buttonType.foreGroundColor,
                    isWide: buttonType != .decimal && buttonType != .equals)
            )
        }
        
       
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(storeManager: StoreManager())
    }
}
