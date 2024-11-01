//
//  TapCalcApp.swift
//  TapCalc
//
//  Created by Matin Iravani on 2024-10-30.
//

import SwiftUI

@main
struct TapCalcApp: App {
    // Create an instance of MainModel
    @StateObject private var mainModel = MainModel()
    @StateObject private var colorModel = ColorThemeModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainModel) // Inject MainModel into the environment
                .environmentObject(colorModel)
        }
    }
}
