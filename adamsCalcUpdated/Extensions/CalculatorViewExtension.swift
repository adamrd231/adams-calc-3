import SwiftUI

struct Size: PreferenceKey {

    typealias Value = [CGRect]
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

extension CalculatorView {
    
    func getButtonSize() -> (height: CGFloat, width: CGFloat) {
        // Width
        let screenWidth = UIScreen.main.bounds.width
        // Number of buttons
        let columnButtonCount: CGFloat = 4
        // Number of spaces
        let spacingCount = columnButtonCount + 1
        // individual button width
        let width = (screenWidth - (spacingCount * Constants.padding)) / columnButtonCount
        
        
        // Height
        let screenHeight = UIScreen.main.bounds.height
        let rowButtonCount: CGFloat = 4.0
        let screenSize = screenHeight * 0.47
        let heightSpacingCount = rowButtonCount + 1
        let height = (screenHeight - (heightSpacingCount * Constants.padding) - (screenSize + 60)) / rowButtonCount
        
        // Return Tuple
        return (height, width)
    }
}
