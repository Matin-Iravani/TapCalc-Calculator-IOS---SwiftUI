//
//  KeyPadView.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-29.
//

import SwiftUI

struct KeyPadView: View {
    
    @EnvironmentObject var mainModel: MainModel
    @EnvironmentObject var colorModel: ColorThemeModel
    
    let screenHeight: CGFloat
    let screenWidth: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                ButtonView(button: DialPad.clear, textColor: colorModel.buttonText2, screenHeight: screenHeight)
                ButtonView(button: DialPad.delete, textColor: colorModel.buttonText2, screenHeight: screenHeight)
                ButtonView(button: DialPad.decimal, textColor: colorModel.buttonText2, screenHeight: screenHeight)
                ButtonView(button: DialPad.devide, textColor: colorModel.buttonText3, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.seven, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.eight, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.nine, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.multiply, textColor: colorModel.buttonText3, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.four, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.five, textColor:colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.six, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.subtract, textColor: colorModel.buttonText3, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.one, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.two, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.three, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.add, textColor: colorModel.buttonText3, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.zero, textColor: colorModel.buttonText1, screenHeight: screenHeight)
                ButtonView(button: DialPad.plusMinus, textColor: colorModel.buttonText2, screenHeight: screenHeight)
                ButtonView(button: DialPad.equal, textColor: colorModel.buttonText3, screenHeight: screenHeight)
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        KeyPadView(screenHeight: geometry.size.height, screenWidth: geometry.size.width)
            .environmentObject(MainModel())
            .environmentObject(ColorThemeModel())
    }
    
}
