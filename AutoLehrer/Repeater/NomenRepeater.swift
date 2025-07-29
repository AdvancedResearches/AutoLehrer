import SwiftUI
import CoreData

struct NomenRepeater: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    
    @State var nomenHive: NomenHive?
    
    var body: some View {
        VStack {
            Text("Placeholder")
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(theme.currentTheme.NG_LinearGradient_Background_Page)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                BackButton(action: {
                    dismiss()
                }, blinking: false)
        )
        
    }
}
