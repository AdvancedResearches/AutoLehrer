import SwiftUI
import CoreData

struct NomenRepeater: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    
    @State var nomenHive: NomenHive?
    @State var nominative_singular_correct: Int = 0
    
    @State var pickedNomenHive: NomenHive?
    @State var nominativ_singular: Nomen?
    
    var body: some View {
        VStack {
            NG_Button(
                title: "Дальше".localized(for: language),
                style: .NG_ButtonStyle_Service,
                isDisabled: .constant(false),
                isHighlighting: .constant(false),
                isPulsating: .constant(false),
                action: {
                    pickTheWord()
                },
                widthFlood: true
            )
            if(pickedNomenHive != nil){
                if(nominativ_singular != nil){
                    Text("Nominative Singlular")
                        .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                    HStack{
                        FlipCard(deutschesSeite: true, deutschesWorte: nominativ_singular!.nomen_DE!, russischesWorte: nominativ_singular!.nomen_RU!, result: $nominative_singular_correct)
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                            .onTapGesture {
                                Statistics.set_success(nominativ_singular!)
                                nominative_singular_correct = 1
                            }
                        Image(systemName: "multiply.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                            .onTapGesture {
                                Statistics.set_failure(nominativ_singular!)
                                nominative_singular_correct = -1
                            }
                    }
                }
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
        .onAppear{
            pickTheWord()
        }
    }
    func pickTheWord() {
        pickedNomenHive = Statistics.pickNomenHive(viewContext)
        if pickedNomenHive != nil {
            nominativ_singular = Nomen.pick_nomenative_singular(pickedNomenHive!)
            nominative_singular_correct = 0
        }
    }
}
