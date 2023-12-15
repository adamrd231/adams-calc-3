import SwiftUI

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
                    AnswerView(
                        numbersArray: vm.numbersArray,
                        operatorsArray: vm.operatorsArray,
                        currentInput: vm.currentInput,
                        currentOperator: vm.currentOperator)
                    variableInputs
                        .padding(.leading)
                    buttonPad
                        .padding(.horizontal)
                }
                AdMobBanner()
                    .padding(.top, 10)
                    .frame(height: 70)
            }
            .preference(key: Size.self, value: [geo.frame(in: CoordinateSpace.global)])
        }
    }
}

//MARK: Views
extension CalculatorView {
    private var variableInputs: some View {
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

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(storeManager: StoreManager())
    }
}

