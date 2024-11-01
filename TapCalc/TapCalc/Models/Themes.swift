//
//  Themes.swift
//  TapCalc
//
//  Created by Matin Iravani on 2024-11-01.
//

import Foundation
import SwiftUI

enum Themes: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case theme1, theme2, theme3, theme4

    // Define colors as computed properties for each theme
    var buttonText1: Color {
        switch self {
        case .theme1: return Color(.label)
        case .theme2: return Color(.label).opacity(0.7)
        case .theme3: return Color.green
        case .theme4: return Color.blue
        }
    }
    
    var buttonText2: Color {
        switch self {
        case .theme1: return Color.indigo
        case .theme2: return Color.red
        case .theme3: return Color.purple
        case .theme4: return Color.yellow
        }
    }
    
    var buttonText3: Color {
        switch self {
        case .theme1: return Color.orange
        case .theme2: return Color.red
        case .theme3: return Color.brown
        case .theme4: return Color.cyan
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .theme1: return Color.indigo.opacity(0.1)
        case .theme2: return Color.pink.opacity(0.1)
        case .theme3: return Color.blue.opacity(0.1)
        case .theme4: return Color.gray.opacity(0.1)
        }
    }
    
    var buttonTapedColor: Color {
        switch self {
        case .theme1: return Color.orange.opacity(0.6)
        case .theme2: return Color.red.opacity(0.4)
        case .theme3: return Color.purple.opacity(0.4)
        case .theme4: return Color.green.opacity(0.4)
        }
    }
    
    var screenBackground: Color {
        switch self {
        case .theme1: return Color.indigo.opacity(0.1)
        case .theme2: return Color.pink.opacity(0.1)
        case .theme3: return Color.yellow.opacity(0.1)
        case .theme4: return Color.black.opacity(0.1)
        }
    }
    
    var screenBorder: Color {
        switch self {
        case .theme1: return Color(.label)
        case .theme2: return Color(.label).opacity(0.7)
        case .theme3: return Color.gray
        case .theme4: return Color.white
        }
    }
    
    var screenStripe1: Color {
        switch self {
        case .theme1: return Color.indigo.opacity(0.7)
        case .theme2: return Color.pink.opacity(0.5)
        case .theme3: return Color.black
        case .theme4: return Color.black
        }
    }
    
    var screenStripe2: Color {
        switch self {
        case .theme1: return Color.orange
        case .theme2: return Color.red.opacity(0.9)
        case .theme3: return Color.black
        case .theme4: return Color.black
        }
    }
    
    var calculatorRunningResultText: Color {
        switch self {
        case .theme1: return Color(.label).opacity(0.5)
        case .theme2: return Color(.label).opacity(0.4)
        case .theme3: return Color.green.opacity(0.5)
        case .theme4: return Color.blue.opacity(0.5)
        }
    }
    
    var calculatorResultText: Color {
        switch self {
        case .theme1: return Color(.label)
        case .theme2: return Color(.label).opacity(0.7)
        case .theme3: return Color.black
        case .theme4: return Color.white
        }
    }
    
    var tabViewSliderCircle: Color {
        switch self {
        case .theme1: return Color.indigo
        case .theme2: return .red
        case .theme3: return .orange
        case .theme4: return .cyan
        }
    }
    
    var contentViewBackground: Color {
        switch self {
        case .theme1: return Color(.systemBackground)
        case .theme2: return Color.pink.opacity(0.2)
        case .theme3: return Color.gray.opacity(0.2)
        case .theme4: return Color.black
        }
    }
}
