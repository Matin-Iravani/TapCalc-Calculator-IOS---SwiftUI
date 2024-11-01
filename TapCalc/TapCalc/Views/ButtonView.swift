import SwiftUI

struct ButtonView: View {
    
    @EnvironmentObject var mainModel: MainModel
    @EnvironmentObject var colorModel: ColorThemeModel
    
    let button: DialPad
    let textColor: Color
    let screenHeight: CGFloat
    
    var body: some View {
        Button {
            // Add any action needed when the button is tapped
            mainModel.doNextOperation(button: button) // Example if you want to set the operation
        } label: {
            let currentColor = (mainModel.currentOperation.rawValue == button.rawValue) ? colorModel.buttonTapedColor : colorModel.buttonColor
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(currentColor)
                .overlay {
                    Text(button.rawValue)
                        .foregroundStyle(textColor)
                        .font(.custom("TitanOne", fixedSize: screenHeight/30))
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        ButtonView(button: DialPad.add, textColor: Color(.label), screenHeight: geometry.size.height)
            //.frame(width: 70, height: 70)
            .environmentObject(MainModel())
            .environmentObject(ColorThemeModel())
    }
    
}
