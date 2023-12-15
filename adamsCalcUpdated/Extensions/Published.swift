
import SwiftUI
import Combine

fileprivate var cancellable = [String : AnyCancellable] ()

extension Published {
    init(wrappedValue value: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
        cancellable[key] = projectedValue.sink { val in
            UserDefaults.standard.set(val, forKey: key)
        }
    }
}
