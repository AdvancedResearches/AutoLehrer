import SwiftUI

struct ChevronView: View {
    @Binding var isExpanded: Bool // Используем для управления состоянием
    //var color: Color = MasterColorSchema.color_dark_most
    @Binding var isHighlighting: Bool
    @Binding var isPulsating: Bool
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Image(systemName: isExpanded ? "chevron.down" : "chevron.right") // Шеврон
            .NG_iconStyling(.NG_IconStyle_Regular, isDisabled: .constant(false), isHighlighting: $isHighlighting, isPulsating: $isPulsating, theme: theme)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle() // Переключаем состояние
                }
            }
    }
}
