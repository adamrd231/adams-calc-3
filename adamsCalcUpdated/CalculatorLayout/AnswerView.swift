import SwiftUI

struct AnswerView: View {
    let numbersArray:[String]
    let operatorsArray:[String]
    let currentInput: String
    let currentOperator: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(numbersArray.indices, id: \.self) { index in
                    Text(numbersArray[index].formattedAsNumber())
                    if index < operatorsArray.count {
                        Text(operatorsArray[index])
                    }
                }
                Text(currentInput.formattedAsNumber())
                Text(currentOperator)
                Spacer(minLength: 0)
            }
            .lineLimit(1)
            .font(.system(size: 50))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
        }
        .foregroundColor(Color.theme.textColor)
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(
            numbersArray: ["12.3"],
            operatorsArray: [],
            currentInput: "",
            currentOperator: "+")
    }
}
