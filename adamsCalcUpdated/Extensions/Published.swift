//
//  Published.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 9/26/22.
//

import Foundation

extension Published {
    init(wrappedValue value: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? value
        self.init(initialValue: value)
//        cancellable[key] = projectedValue.sink { val in
//            UserDefaults.standard.set(val, forKey: key)
//        }
    }
}
