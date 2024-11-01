import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @EnvironmentObject var colorModel: ColorThemeModel
    
    @State private var currentPage = 0
    
    let generator2 = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CalculatorScreenView(screenHeight: geometry.size.height, screenWidth: geometry.size.width)
                    .padding(.bottom)
                
                // KeyPadView with custom drag gesture
                Group {
                    if currentPage == 0 {
                        KeyPadView(screenHeight: geometry.size.height, screenWidth: geometry.size.width)
                            .transition(currentPage == 0 ? .move(edge: .leading) : .move(edge: .trailing))
                    } else if currentPage == 1 {
                        ScrollingThemeSelectionView(screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                            .transition(currentPage == 1 ? .move(edge: .trailing) : .move(edge: .leading))
                    }
                }
                .frame(height: geometry.size.height / 3 * 1.9)
                .animation(.easeInOut, value: currentPage) // Smooth animation for page change
                .gesture(
                    DragGesture()
                
                        .onEnded { value in
                            let threshold: CGFloat = geometry.size.width/4 // Adjust sensitivity threshold
                            withAnimation {
                                if value.translation.width > threshold && currentPage > 0 {
                                    generator2.impactOccurred()
                                    currentPage -= 1
                                } else if value.translation.width < -threshold && currentPage < 1 {
                                    generator2.impactOccurred()
                                    currentPage += 1
                                }
                            }
                        }
                    )
                
                // Page indicators
                HStack {
                    Image(systemName: currentPage == 0 ? "circle.fill" : "circle")
                        .opacity(currentPage == 0 ? 1 : 0.5)
                        .imageScale(.small)
                    Image(systemName: currentPage == 1 ? "circle.fill" : "circle")
                        .opacity(currentPage == 1 ? 1 : 0.5)
                        .imageScale(.small)
                }
                .padding(.top, 40)
                .foregroundStyle(colorModel.tabViewSliderCircle)
                .frame(height: 0)
            }
            .padding(.top)
            .padding(.bottom)
            .padding(.horizontal)
            .background(colorModel.contentViewBackground)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MainModel())
        .environmentObject(ColorThemeModel())
}
