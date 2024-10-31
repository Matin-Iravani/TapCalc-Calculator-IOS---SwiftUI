//
//  KeyPadView.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-29.
//

import SwiftUI

struct KeyPadView: View {
    
    @EnvironmentObject var mainModel: MainModel
    
    let screenHeight: CGFloat
    let screenWidth: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                ButtonView(button: DialPad.clear, textColor: Color.indigo, screenHeight: screenHeight)
                ButtonView(button: DialPad.delete, textColor: Color.indigo, screenHeight: screenHeight)
                ButtonView(button: DialPad.decimal, textColor: Color.indigo, screenHeight: screenHeight)
                ButtonView(button: DialPad.devide, textColor: Color.orange, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.seven, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.eight, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.nine, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.multiply, textColor: Color.orange, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.four, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.five, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.six, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.subtract, textColor: Color.orange, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.one, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.two, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.three, textColor: Color(.label), screenHeight: screenHeight)
                ButtonView(button: DialPad.add, textColor: Color.orange, screenHeight: screenHeight)
            }
            
            HStack {
                ButtonView(button: DialPad.zero, textColor: Color(.label), screenHeight: screenHeight)
                //ButtonView(button: DialPad.zero, textColor: Color.indigo, screenHeight: screenHeight)
                ButtonView(button: DialPad.plusMinus, textColor: Color.indigo, screenHeight: screenHeight)
                ButtonView(button: DialPad.equal, textColor: Color.orange, screenHeight: screenHeight)
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        KeyPadView(screenHeight: geometry.size.height, screenWidth: geometry.size.width)
            .environmentObject(MainModel())
    }
    
}
