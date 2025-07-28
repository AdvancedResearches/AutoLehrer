import Foundation

extension String{
    func localized(for language: String) -> String {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self // fallback
        }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
