//
//  ScreenShape.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-29.
//

import SwiftUI

struct ScreenShape: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.indigo).opacity(0.1)
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 4)
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
}
