//
//  ButtonPad.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 9/26/22.
//

import SwiftUI

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
    case variable(value: Double)
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
        case .variable(let variable): return variable.description
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
        case .variable: return Color.red
        case .allClear, .clear, .negative, .percent: return Color.theme.blue
        case .operation, .equals: return Color.theme.darkGray
        case .digit, .decimal: return Color.theme.lightGray
        }
    }
    
    var foreGroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent, .operation, .equals, .variable: return .white
        default: return .black
        }
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    var size: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    var isWide: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 26, weight: .bold))
            .frame(width: size, height: size)
            .frame(maxWidth: isWide ? .infinity : size)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay {
                if configuration.isPressed {
                    Color.gray.opacity(0.4)
                }
            }
            .clipShape(Capsule())
    }
}

