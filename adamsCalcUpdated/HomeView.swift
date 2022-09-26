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


enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    var description: String {
        "\(rawValue)"
    }
}

enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division
    
    var description: String {
        switch self {
        case .addition: return "+"
        case .subtraction: return "-"
        case .multiplication: return "x"
        case .division: return "/"
        }
    }
}

enum ButtonType: Hashable, CustomStringConvertible {

    case digit(_ digit: Digit)
    case operation(_ operation: ArithmeticOperation)
    case negative
    case percent
    case decimal
    case equals
    case allClear
    case clear
    
    var description: String {
        switch self {
        case .digit(let digit): return digit.description
        case .operation(let operation): return operation.description
        case .negative: return "+/-"
        case .percent: return "%"
        case .decimal: return "."
        case .equals: return "="
        case .allClear: return "A/C"
        case .clear: return "<-"
        }
    }
    
    var backGroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent: return Color.theme.blue
        case .operation, .equals: return Color.theme.darkGray
        case .digit, .decimal: return Color.theme.lightGray
        }
    }
    
    var foreGroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent, .operation, .equals: return .white
        default: return .black
        }
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    var size: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 32, weight: .bold))
            .frame(width: size, height: size)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    Color(white: 1.0, opacity: 0.2)
                }
            }
            .clipShape(Capsule())
    }
}

extension HomeView {
    struct CalculatorButton: View {
        let buttonType: ButtonType
        
        var body: some View {
            Button(buttonType.description) { }
                .buttonStyle(
                    CalculatorButtonStyle(
                        size: getButtonSize(),
                        backgroundColor: buttonType.backGroundColor,
                        foregroundColor: buttonType.foreGroundColor)
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



struct HomeView: View {
    
    @EnvironmentObject var calculator: Calculator
    @StateObject var storeManager: StoreManager
    
    @StateObject var vm = CalculatorViewModel()
    @State var numberOfDecimals = 3
    @State var finalAnswer:Double?
    
    var buttonTypes: [[ButtonType]] {
        [
            [.allClear, .negative, .percent, .operation(.division)],
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
    
    private var buttonPad: some View {
        VStack(spacing: Constants.padding) {
            ForEach(buttonTypes, id: \.self) { buttonRow in
                HStack(spacing: Constants.padding) {
                    ForEach(buttonRow, id: \.self) { buttonType in
                        CalculatorButton(buttonType: buttonType)
                    }
                }
            }
        }
    }
    
    private var displayText: some View {
        // Answers
        VStack {
            Text("28 + 5")
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .font(.largeTitle)
        }
    }
}
