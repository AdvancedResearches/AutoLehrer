import SwiftUI

struct LaunchScreen: View {
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var presetsProgress: PresetsProgressOO
    
    var body: some View {
        ZStack {
            theme.currentTheme.NG_LinearGradient_Background_Page.ignoresSafeArea() // Теперь фон на весь экран
            
            VStack {
                Image("LaunchScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.9) // 90% ширины экрана
                    .aspectRatio(1, contentMode: .fit) // Высота = ширине (квадрат)
                
                Text("Cards RU-DE") // Текст загрузки
                    .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                    .padding(10)
                Text("Запускается...")
                    .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                    .padding(10)
                
                Text(presetsProgress.text)  // ← сюда приходит прогресс
                    .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                    .padding(10)
                
                ProgressView(value: presetsProgress.fraction) // ← если захочешь прогресс-бар
                    .padding(.horizontal, 32)
            }
        }
    }
}
