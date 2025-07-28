import SwiftUI

struct AppLanguageKey: EnvironmentKey {
    static var defaultValue: String {
        UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
    }
}

extension EnvironmentValues {
    var appLanguage: String {
        get { self[AppLanguageKey.self] }
        set { self[AppLanguageKey.self] = newValue }
    }
}

