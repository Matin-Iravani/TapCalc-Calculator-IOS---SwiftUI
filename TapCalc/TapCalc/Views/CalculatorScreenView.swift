//
//  CalculatorScreenView.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-29.
//

import SwiftUI

struct CalculatorScreenView: View {
    
    @EnvironmentObject var mainModel: MainModel
    @EnvironmentObject var colorModel: ColorThemeModel
    
    let screenHeight: CGFloat
    let screenWidth: CGFloat
    
    func formatWithThousandsSeparator(_ numberString: String) -> String? {
        guard let number = Double(numberString) else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number))
    }
    
    
    var body: some View {
        //hi
        ZStack {
            ScreenShape()
                .background() {
                    VStack (spacing: 0) {
                        Spacer()
                        
                        Rectangle()
                            .frame(height: screenHeight/35)
                            .foregroundStyle(colorModel.screenStripe1)
                        Rectangle()
                            .frame(height: screenHeight/35)
                            .foregroundStyle(colorModel.screenStripe2)
                    }
                    .clipShape(ScreenShapeShape())
                    
                }
                .frame(maxWidth: .infinity, maxHeight: screenHeight/3)
        }
        .overlay(alignment: .trailing) {
            VStack  {
                HStack {
                    Spacer()
                    Text(self.mainModel.runningExpression)
                        .foregroundStyle(colorModel.calculatorRunningResultText)
                        .font(.custom("TitanOne", fixedSize: screenHeight/20))
                        .tracking(4)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .scaleEffect(0.99)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .move(edge: .trailing)),
                            removal: .scale.combined(with: .move(edge: .leading))
                        ))
                        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0), value: self.mainModel.runningExpression)
                }
                .frame(height: screenHeight/20)
                
                HStack {
                    Spacer()
                    Text(self.mainModel.result.isEmpty ? "0" : formatWithThousandsSeparator(self.mainModel.result) ?? "Error")
                        .foregroundStyle(colorModel.calculatorResultText)
                        .font(.custom("TitanOne", fixedSize: screenHeight/15))
                        .tracking(4)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .rotation3DEffect(
                            .degrees(self.mainModel.result.isEmpty ? 90 : 0),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .scaleEffect(self.mainModel.result.isEmpty ? 0.8 : 1)
                        .opacity(self.mainModel.result.isEmpty ? 0 : 1)
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.8).combined(with: .opacity),
                            removal: .scale(scale: 1.2).combined(with: .opacity)
                        ))
                        .animation(.easeInOut(duration: 0.5), value: self.mainModel.result)
                }
                .frame(height: screenHeight/10)
            }
            .padding(.horizontal)
            .mask(ScreenShapeShape())
        }
    }
}



#Preview {
    GeometryReader { geometry in
        CalculatorScreenView(screenHeight: geometry.size.height, screenWidth: geometry.size.width)
            .padding()
            .environmentObject(MainModel())
            .environmentObject(ColorThemeModel())
    }
    
    
}
