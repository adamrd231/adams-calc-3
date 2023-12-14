import SwiftUI

struct Size: PreferenceKey {

    typealias Value = [CGRect]
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct CalculatorView: View {
    @ObservedObject var vm = CalculatorViewViewModel()
    @StateObject var storeManager: StoreManager
    @State var numberOfDecimals = 3
    @State var playerFrame = CGRect.zero
    
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
        GeometryReader { geo in
            VStack {
                VStack {
                    Spacer()
                    displayText
                    variableInputs
                        .padding(.leading)
                    buttonPad
                        .padding(.horizontal)
                }
                AdMobBanner()
                    .frame(height: 60)
            }
            .preference(key: Size.self, value: [geo.frame(in: CoordinateSpace.global)])
        }
    }
}

//MARK: Views
extension CalculatorView {
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
    
    private var variableInputs: some View {
//        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    if vm.savedEquations.count == 0 {
                        Text("...")
                            .padding(10)
                            .background(Color.theme.darkGray)
                            .cornerRadius(5)
                            .foregroundColor(Color.theme.lightGray)
                    } else {
                        ForEach(vm.savedEquations.reversed(), id: \.self) { saved in
                            Button(saved) {
                                if vm.currentOperator == "" {
                                    vm.currentInput = saved
                                } else {
                                    vm.numbersArray.append(vm.currentInput)
                                    vm.operatorsArray.append(vm.currentOperator)
                                    vm.currentOperator = ""
                                    vm.currentInput = saved
                                }
                            }
                            .background(Color.theme.darkGray)
                            .foregroundColor(Color.theme.lightGray)
                            .font(.callout)
                            .buttonStyle(.bordered)
                            .cornerRadius(5)
                        }
                    }
                }
            }
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
        
//        }
    }
    
    private var buttonPad: some View {
        ForEach(buttonTypes, id: \.self) { buttonRow in
            HStack(spacing: Constants.padding) {
                ForEach(buttonRow, id: \.self) { buttonType in
                    CalculatorButton(buttonType: buttonType, vm: vm, function: getButtonSize)
                }
            }
        }
    }
}

//MARK: Calculator Button Extensions
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

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(storeManager: StoreManager())
    }
}

