//
//  ScreenShape.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-29.
//

import SwiftUI

struct ScreenShape: View {
    
    @EnvironmentObject var colorModel: ColorThemeModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(colorModel.screenBackground)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 4)
                .foregroundStyle(colorModel.screenBorder)
        }
    }
}

struct ScreenShapeShape: Shape {
    func path(in rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: 20).path(in: rect)
    }
}

#Preview {
    ScreenShape()
        .environmentObject(ColorThemeModel())
}
