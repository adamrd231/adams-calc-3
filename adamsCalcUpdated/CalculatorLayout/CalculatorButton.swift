import SwiftUI

struct CalculatorButton: View {
    let buttonType: ButtonType
    let vm: CalculatorViewViewModel
    var function: () -> (height: CGFloat, width: CGFloat)
    
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
