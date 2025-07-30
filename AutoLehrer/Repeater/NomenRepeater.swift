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
            let pickedNomenHive = Statistics.pickNomenHive(viewContext)
            let nominativ_singular = Nomen.pick_nomenative_singular(pickedNomenHive)
            Text(nominativ_singular.nomen_DE!)
                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
            Text(nominativ_singular.nomen_RU!)
                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
            //Text("Placeholder")
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .NG_Card(.NG_CardStyle_Regular, theme: theme)
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
