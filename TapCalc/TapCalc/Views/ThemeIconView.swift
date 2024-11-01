import SwiftUI

struct ThemeIconView: View {
    
    let screenHeight: CGFloat
    let screenWidth: CGFloat
    let selectedTheme: Themes
    
    let columns = [
        GridItem(.flexible()), // Adjusts size to fill available space
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: screenWidth / 20)
                .foregroundStyle(selectedTheme.contentViewBackground)
                .frame(width: screenWidth / 4.9, height: screenWidth / 4.9)
                .overlay(
                    RoundedRectangle(cornerRadius: screenWidth / 20)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(selectedTheme.screenBorder)
                )
                .overlay {
                    LazyVGrid(columns: columns) {
                        ForEach(buttonIcons, id: \.0) { icon, color in
                            iconView(icon: icon, color: color)
                        }
                    }
                    .foregroundStyle(selectedTheme.buttonColor)
                    .padding(screenWidth / 80)
                }
        }
    }
    
    // Helper function for icons
    private func iconView(icon: String, color: Color) -> some View {
        Circle()
            .foregroundStyle(Color.clear)
            .overlay(RoundedRectangle(cornerRadius: screenWidth / 45))
            .overlay(
                Text(icon)
                    .font(.custom("TitanOne", size: screenWidth / 15))
                    .foregroundStyle(color)
            )
    }
    
    // Array for button icons and their colors
    private var buttonIcons: [(String, Color)] {
        [
            ("+", selectedTheme.buttonText1),
            ("-", selectedTheme.buttonText2),
            ("/", selectedTheme.buttonText3),
            ("=", selectedTheme.buttonText1)
        ]
    }
}

#Preview {
    GeometryReader { geometry in
        ThemeIconView(screenHeight: geometry.size.height, screenWidth: geometry.size.width, selectedTheme: Themes.theme2)
    }
}
