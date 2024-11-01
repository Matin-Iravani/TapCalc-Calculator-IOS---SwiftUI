//
//  ColorThemeModel.swift
//  TapCalc
//
//  Created by Matin Iravani on 2024-10-31.
//

import Foundation
import SwiftUI

class ColorThemeModel: ObservableObject {
    
    // MARK: Variables
    
    @AppStorage("currentTheme") private var storedTheme: Themes = Themes.theme2
    
    @Published var calculatorRunningResultText = Color(.label).opacity(0.5)
    @Published var calculatorResultText = Color(.label)
    @Published var buttonText1 = Color(.label)
    @Published var buttonText2 = Color.indigo
    @Published var buttonText3 = Color.orange
    @Published var buttonColor = Color.indigo.opacity(0.1)
    @Published var buttonTapedColor = Color.orange.opacity(0.6)
    @Published var screenBackground = Color.indigo.opacity(0.1)
    @Published var screenBorder = Color(.label)
    @Published var screenStripe1 = Color.indigo.opacity(0.7)
    @Published var screenStripe2 = Color.orange
    @Published var tabViewSliderCircle = Color.indigo
    @Published var contentViewBackground = Color(.systemBackground)
    
    
    init () {
        applyTheme(selectedTheme: storedTheme)
    }
    
    func changeTheme(selectedTheme: Themes) {
        storedTheme = selectedTheme
        applyTheme(selectedTheme: selectedTheme)
    }
    
    func applyTheme(selectedTheme: Themes) {
        buttonText1 = selectedTheme.buttonText1
        buttonText2 = selectedTheme.buttonText2
        buttonText3 = selectedTheme.buttonText3
        buttonColor = selectedTheme.buttonColor
        buttonTapedColor = selectedTheme.buttonTapedColor
        screenBackground = selectedTheme.screenBackground
        screenBorder = selectedTheme.screenBorder
        screenStripe1 = selectedTheme.screenStripe1
        screenStripe2 = selectedTheme.screenStripe2
        tabViewSliderCircle = selectedTheme.tabViewSliderCircle
        calculatorRunningResultText = selectedTheme.calculatorRunningResultText
        calculatorResultText = selectedTheme.calculatorResultText
        contentViewBackground = selectedTheme.contentViewBackground
    }
}
