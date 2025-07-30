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
            Text("Nominative Singlular")
                .NG_textStyling(.NG_TextStyle_Title, theme: theme)
            HStack{
                FlipCard(deutschesSeite: true, deutschesWorte: nominativ_singular.nomen_DE!, russischesWorte: nominativ_singular.nomen_RU!)
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                Image(systemName: "multiply.square.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
            }
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
