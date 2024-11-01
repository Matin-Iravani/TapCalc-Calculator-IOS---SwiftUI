//
//  empty.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-30.
//

import SwiftUI

struct empty: View {
    
    let screenHeight: CGFloat
    let screenWidth: CGFloat
    let selectedTheme: Themes
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(selectedTheme.contentViewBackground)
            .frame(width: screenWidth/5, height: screenWidth/5)
            .overlay() {
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(selectedTheme.buttonColor)
                            .frame(width: screenWidth/15, height: screenWidth/15)
                            .overlay() {
                                Text("+")
                                    .font(.custom("TitanOne", size: screenWidth/20))
                                    .foregroundStyle(selectedTheme.buttonText1)
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(selectedTheme.buttonColor)
                            .frame(width: screenWidth/15, height: screenWidth/15)
                            .overlay() {
                                Text("-")
                                    .font(.custom("TitanOne", size: screenWidth/20))
                                    .foregroundStyle(selectedTheme.buttonText2)
                            }
                    }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(selectedTheme.buttonColor)
                            .frame(width: screenWidth/15, height: screenWidth/15)
                            .overlay() {
                                Text("/")
                                    .font(.custom("TitanOne", size: screenWidth/20))
                                    .foregroundStyle(selectedTheme.buttonText3)
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(selectedTheme.buttonColor)
                            .frame(width: screenWidth/15, height: screenWidth/15)
                            .overlay() {
                                Text("=")
                                    .font(.custom("TitanOne", size: screenWidth/20))
                                    .foregroundStyle(selectedTheme.buttonText1)
                            }
                    }
                }
                
            }
    }
}

#Preview {
    GeometryReader { geometry in
        empty(screenHeight: geometry.size.height, screenWidth: geometry.size.width, selectedTheme: Themes.theme2)
            .padding()
    }
}
