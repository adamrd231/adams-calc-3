//
//  ContentView.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

class HomeViewViewModel: ObservableObject {
    @StateObject var calculator = Calculator()
    
    @Published(key: "NumbersArray") var numbersArray:[Double] = []
    @Published(key: "OperatorsArray") var operatorsArray:[String] = []
    @Published(key: "CurrentInput") var currentInput = ""
    @Published(key: "CurrentOperator") var currentOperator = ""

    var performingMath = false
    var isInputingNumber = false
    
    @Published(key: "SaveButtonOne") var saveButtonOne = ""
    @Published(key: "SaveButtonOneLocked") var saveButtonOneLocked = false
    @Published(key: "SaveButtonTwo") var saveButtonTwo = ""
    @Published(key: "SaveButtonTwoLocked") var saveButtonTwoLocked = false
}

struct HomeView: View {
    
    @ObservedObject var vm = HomeViewViewModel()
    @StateObject var storeManager: StoreManager
    @State var numberOfDecimals = 3
    @State var finalAnswer: Double?
    
    @State var variableButtonOne: Double = 0
    @State var variableButtonTwo: Double = 32.2443
    
    var buttonTypes: [[ButtonType]] {
        [
            [.variable(value: variableButtonOne), .variable(value: variableButtonTwo)],
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
    
    func formatNumber(number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = numberOfDecimals
        
        let number = NSNumber(value: number)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
    
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
        VStack {
            Text(vm.currentInput)
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .font(.largeTitle)
        }
    }
}

//MARK: Calculator Button Extensions
extension HomeView {
    struct CalculatorButton: View {
        let buttonType: ButtonType
        let vm: HomeViewViewModel
        
        var body: some View {
            Button(buttonType.description) {
                print("Pressed \(buttonType.description), which is a \(buttonType)")
                vm.currentInput = buttonType.description
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
