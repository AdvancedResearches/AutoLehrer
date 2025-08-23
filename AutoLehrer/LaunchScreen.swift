import SwiftUI

struct LaunchScreen: View {
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var presetsProgress: PresetsProgressOO
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "—"
        return "v\(version).\(build)"
    }
    
    var body: some View {
        ZStack {
            theme.currentTheme.NG_LinearGradient_Background_Page.ignoresSafeArea() // Теперь фон на весь экран
            
            VStack {
                Image("LaunchScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.9) // 90% ширины экрана
                    .aspectRatio(1, contentMode: .fit) // Высота = ширине (квадрат)
                
                Text("Карточки - немецкий") // Текст загрузки
                    .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                Text(appVersion)
                        .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                        .padding(.bottom, 10)
                Text("Запускается...")
                    .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                    .padding(10)
                
                Text(presetsProgress.text)
                                    .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                                    .padding(.horizontal, 10)

                if !presetsProgress.completed {
                    ProgressView(value: presetsProgress.fraction)
                        .padding(.horizontal, 32)
                        .padding(.top, 6)
                }
            }
        }
    }
}
