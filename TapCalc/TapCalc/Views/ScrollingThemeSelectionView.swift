//
//  ScrollingThemeSelectionView.swift
//  TapCalc
//
//  Created by Matin Iravani on 2024-11-01.
//

import SwiftUI

struct ScrollingThemeSelectionView: View {
    
    @EnvironmentObject var colorModel: ColorThemeModel
    
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    let columns = [
            GridItem(.flexible()), // Adjusts size to fill available space
            GridItem(.flexible()), // Creates two flexible columns
            GridItem(.flexible())
        ]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(colorModel.buttonColor)
            .overlay() {
                VStack {
                    Text("Choose a theme...")
                        .font(.custom("TitanOne", size: screenWidth/15))
                        .foregroundStyle(colorModel.calculatorResultText)
                        .padding()
                    
                    Rectangle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [colorModel.screenStripe1, colorModel.screenStripe2]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )) // Set the color
                        .frame(height: 5)
                        .padding(.horizontal)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .center, spacing: screenHeight/20) {
                            ForEach(Themes.allCases) { theme in
                                ThemeIconView(screenHeight: screenHeight, screenWidth: screenWidth, selectedTheme: theme)
                                    .background(RoundedRectangle(cornerRadius: screenWidth/20).foregroundStyle(Color(.systemBackground)))
                                    .onTapGesture {
                                        colorModel.changeTheme(selectedTheme: theme)
                                            
                            }
                        }
                    }
                        .padding(.top)
                    .padding(.bottom, 100)
                }
            }
        }
    }
}

#Preview {
    GeometryReader { geomtry in
        ScrollingThemeSelectionView(screenWidth: geomtry.size.width, screenHeight: geomtry.size.height)
            .environmentObject(ColorThemeModel())
    }
    
}
