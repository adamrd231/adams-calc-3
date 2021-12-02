//
//  adamsCalcUpdatedApp.swift
//  adamsCalcUpdated
//
//  Created by Adam Reed on 12/1/21.
//

import SwiftUI

@main
struct adamsCalcUpdatedApp: App {
    
    @StateObject var calculator = Calculator()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(calculator)
        }
    }
}
