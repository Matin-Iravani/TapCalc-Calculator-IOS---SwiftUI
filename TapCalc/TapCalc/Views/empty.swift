//
//  empty.swift
//  Calculator
//
//  Created by Matin Iravani on 2024-10-30.
//

import SwiftUI

struct empty: View {
    var body: some View {
        VStack {
            Rectangle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        
    }
}

#Preview {
    empty()
}
