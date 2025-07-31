import SwiftUI
import CoreData

struct NomenRepeater: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    
    @State var pickedNomenHive: NomenHive?
    
    @State var nominativ_singular_correct: Int = 0
    @State var nominativ_singular: Nomen?
    @State var nominativ_singular_deutschesSeite: Bool = false
    
    @State var genitiv_singular_correct: Int = 0
    @State var genitiv_singular: Nomen?
    @State var genitiv_singular_deutschesSeite: Bool = false
    
    @State var exercisedWords: Set<NomenHive> = []
    @State var confirmedWords: Set<NomenHive> = []
    
    var body: some View {
        VStack{
            HStack{
                Text("Выучено слов \(confirmedWords.count) из \(exercisedWords.count)")
                Spacer()
            }
            VStack {
                NG_Button(
                    title: "Дальше".localized(for: language),
                    style: .NG_ButtonStyle_Service,
                    isDisabled: .constant(false),
                    isHighlighting: .constant(false),
                    isPulsating: .constant(false),
                    action: {
                        if(nominativ_singular_correct == 1){
                            Statistics.set_success(nominativ_singular!)
                        }
                        if(nominativ_singular_correct == -1){
                            Statistics.set_failure(nominativ_singular!)
                        }
                        if(nominativ_singular != nil ? nominativ_singular_correct == 1 : true && genitiv_singular != nil ? genitiv_singular_correct == 1 : true ){
                            if(NomenHive.set_success(pickedNomenHive!)){
                                confirmedWords.insert(pickedNomenHive!)
                            }
                        }else{
                            NomenHive.set_failure(pickedNomenHive!)
                            confirmedWords.remove(pickedNomenHive!)
                        }
                        pickTheWord()
                    },
                    widthFlood: true
                )
                if(pickedNomenHive != nil){
                    HStack{
                        Text("Правильно \(pickedNomenHive!.successCounter) раз подряд")
                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        Spacer()
                    }
                }
                if(pickedNomenHive != nil){
                    if(nominativ_singular != nil){
                        Text("Nominativ Singlular")
                            .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                        Text(genitiv_singular_deutschesSeite ? "Wer? Was?" : "Кто? Что?")
                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        HStack{
                            FlipCard(deutschesSeite: $nominativ_singular_deutschesSeite, deutschesWorte: nominativ_singular!.nomen_DE!, russischesWorte: nominativ_singular!.nomen_RU!, result: $nominativ_singular_correct)
                            Image(systemName: "checkmark.square.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                .onTapGesture {
                                    nominativ_singular_correct = 1
                                }
                            Image(systemName: "multiply.square.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                .onTapGesture {
                                    nominativ_singular_correct = -1
                                }
                        }
                    }
                    if(genitiv_singular != nil){
                        Text("Genitiv Singlular")
                            .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                        Text(genitiv_singular_deutschesSeite ? "Wessen?" : "Кого? Чего?")
                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        HStack{
                            FlipCard(deutschesSeite: $genitiv_singular_deutschesSeite, deutschesWorte: genitiv_singular!.nomen_DE!, russischesWorte: genitiv_singular!.nomen_RU!, result: $genitiv_singular_correct)
                            Image(systemName: "checkmark.square.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                .onTapGesture {
                                    genitiv_singular_correct = 1
                                }
                            Image(systemName: "multiply.square.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                .onTapGesture {
                                    genitiv_singular_correct = -1
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
    }
    func pickTheWord() {
        pickedNomenHive = Statistics.pickNomenHive(viewContext)
        if pickedNomenHive != nil {
            exercisedWords.insert(pickedNomenHive!)
            nominativ_singular = Nomen.pick_nomenativ_singular(pickedNomenHive!)
            nominativ_singular_correct = nominativ_singular != nil ? 0 : 1
            nominativ_singular_deutschesSeite = false
            
            genitiv_singular = Nomen.pick_genitiv_singular(pickedNomenHive!)
            genitiv_singular_correct = genitiv_singular != nil ? 0 : 1
            genitiv_singular_deutschesSeite = false
        }
    }
}
