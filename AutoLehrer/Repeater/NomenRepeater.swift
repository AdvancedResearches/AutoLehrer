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
    @State var nominativ_singular_beispiel: Beispiel?
    @State var nominativ_singular_deutschesSeite: Bool = false
    
    @State var genitiv_singular_correct: Int = 0
    @State var genitiv_singular: Nomen?
    @State var genitiv_singular_beispiel: Beispiel?
    @State var genitiv_singular_deutschesSeite: Bool = false
    
    @State var akkusativ_singular_correct: Int = 0
    @State var akkusativ_singular: Nomen?
    @State var akkusativ_singular_beispiel: Beispiel?
    @State var akkusativ_singular_deutschesSeite: Bool = false
    
    @State var dativ_singular_correct: Int = 0
    @State var dativ_singular: Nomen?
    @State var dativ_singular_beispiel: Beispiel?
    @State var dativ_singular_deutschesSeite: Bool = false
    
    @State var nominativ_plural_correct: Int = 0
    @State var nominativ_plural: Nomen?
    @State var nominativ_plural_beispiel: Beispiel?
    @State var nominativ_plural_deutschesSeite: Bool = false
    
    @State var genitiv_plural_correct: Int = 0
    @State var genitiv_plural: Nomen?
    @State var genitiv_plural_beispiel: Beispiel?
    @State var genitiv_plural_deutschesSeite: Bool = false
    
    @State var akkusativ_plural_correct: Int = 0
    @State var akkusativ_plural: Nomen?
    @State var akkusativ_plural_beispiel: Beispiel?
    @State var akkusativ_plural_deutschesSeite: Bool = false
    
    @State var dativ_plural_correct: Int = 0
    @State var dativ_plural: Nomen?
    @State var dativ_plural_beispiel: Beispiel?
    @State var dativ_plural_deutschesSeite: Bool = false
    
    @State var exercisedWords: Set<NomenHive> = []
    @State var confirmedWords: Set<NomenHive> = []
    
    var body: some View {
        VStack{
            HStack{
                Text("Выучено слов \(confirmedWords.count) из \(exercisedWords.count)")
                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
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
                        NomenHive.set_attempted(pickedNomenHive!)
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
                    ScrollView(.vertical){
                        
                        if(nominativ_singular != nil){
                            Divider()
                            Text("Nominativ Singlular")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            Text(genitiv_singular_deutschesSeite ? "Wer? Was?" : "Кто? Что?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(nominativ_singular_beispiel != nil){
                                    FlipCard(deutschesSeite: $nominativ_singular_deutschesSeite, deutschesWorte: nominativ_singular!.nomen_DE!, russischesWorte: nominativ_singular!.nomen_RU!, deutschesBeispeil: nominativ_singular_beispiel!.beispiel_DE!, russischesBeispeil: nominativ_singular_beispiel!.beispiel_RU!, result: $nominativ_singular_correct)
                                }else{
                                    FlipCard(deutschesSeite: $nominativ_singular_deutschesSeite, deutschesWorte: nominativ_singular!.nomen_DE!, russischesWorte: nominativ_singular!.nomen_RU!, result: $nominativ_singular_correct)
                                }
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
                            Divider()
                            Text("Genitiv Singlular")
                                .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                            Text(genitiv_singular_deutschesSeite ? "Wessen?" : "Кого? Чего?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(genitiv_singular_beispiel != nil){
                                    FlipCard(deutschesSeite: $genitiv_singular_deutschesSeite, deutschesWorte: genitiv_singular!.nomen_DE!, russischesWorte: genitiv_singular!.nomen_RU!, deutschesBeispeil: genitiv_singular_beispiel!.beispiel_DE!, russischesBeispeil: genitiv_singular_beispiel!.beispiel_RU!, result: $nominativ_singular_correct)
                                }else{
                                    FlipCard(deutschesSeite: $genitiv_singular_deutschesSeite, deutschesWorte: genitiv_singular!.nomen_DE!, russischesWorte: genitiv_singular!.nomen_RU!, result: $genitiv_singular_correct)
                                }
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
                        if(akkusativ_singular != nil){
                            Divider()
                            Text("Akkusativ Singlular")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            Text(akkusativ_singular_deutschesSeite ? "Wen? Was?" : "Кого? Что?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(akkusativ_singular_beispiel != nil){
                                    FlipCard(deutschesSeite: $akkusativ_singular_deutschesSeite, deutschesWorte: akkusativ_singular!.nomen_DE!, russischesWorte: akkusativ_singular!.nomen_RU!, deutschesBeispeil: akkusativ_singular_beispiel!.beispiel_DE!, russischesBeispeil: akkusativ_singular_beispiel!.beispiel_RU!, result: $akkusativ_singular_correct)
                                }else{
                                    FlipCard(deutschesSeite: $akkusativ_singular_deutschesSeite, deutschesWorte: akkusativ_singular!.nomen_DE!, russischesWorte: akkusativ_singular!.nomen_RU!, result: $akkusativ_singular_correct)
                                }
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        akkusativ_singular_correct = 1
                                    }
                                Image(systemName: "multiply.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        akkusativ_singular_correct = -1
                                    }
                            }
                        }
                        if(dativ_singular != nil){
                            Divider()
                            Text("Dativ Singlular")
                                .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                            Text(dativ_singular_deutschesSeite ? "Wem?" : "Кому? Чему?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(dativ_singular_beispiel != nil){
                                    FlipCard(deutschesSeite: $dativ_singular_deutschesSeite, deutschesWorte: dativ_singular!.nomen_DE!, russischesWorte: dativ_singular!.nomen_RU!, deutschesBeispeil: dativ_singular_beispiel!.beispiel_DE!, russischesBeispeil: dativ_singular_beispiel!.beispiel_RU!, result: $dativ_singular_correct)
                                }else{
                                    FlipCard(deutschesSeite: $dativ_singular_deutschesSeite, deutschesWorte: dativ_singular!.nomen_DE!, russischesWorte: dativ_singular!.nomen_RU!, result: $dativ_singular_correct)
                                }
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        dativ_singular_correct = 1
                                    }
                                Image(systemName: "multiply.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        dativ_singular_correct = -1
                                    }
                            }
                        }
                        
                        if(nominativ_plural != nil){
                            Divider()
                            Text("Nominativ Plural")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            Text(genitiv_plural_deutschesSeite ? "Wer? Was?" : "Кто? Что?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(nominativ_plural_beispiel != nil){
                                    FlipCard(deutschesSeite: $nominativ_plural_deutschesSeite, deutschesWorte: nominativ_plural!.nomen_DE!, russischesWorte: nominativ_plural!.nomen_RU!, deutschesBeispeil: nominativ_plural_beispiel!.beispiel_DE!, russischesBeispeil: nominativ_plural_beispiel!.beispiel_RU!, result: $nominativ_plural_correct)
                                }else{
                                    FlipCard(deutschesSeite: $nominativ_plural_deutschesSeite, deutschesWorte: nominativ_plural!.nomen_DE!, russischesWorte: nominativ_plural!.nomen_RU!, result: $nominativ_plural_correct)
                                }
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        nominativ_plural_correct = 1
                                    }
                                Image(systemName: "multiply.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        nominativ_plural_correct = -1
                                    }
                            }
                        }
                        if(genitiv_plural != nil){
                            Divider()
                            Text("Genitiv Plural")
                                .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                            Text(genitiv_plural_deutschesSeite ? "Wessen?" : "Кого? Чего?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(genitiv_plural_beispiel != nil){
                                    FlipCard(deutschesSeite: $genitiv_plural_deutschesSeite, deutschesWorte: genitiv_plural!.nomen_DE!, russischesWorte: genitiv_plural!.nomen_RU!, deutschesBeispeil: genitiv_plural_beispiel!.beispiel_DE!, russischesBeispeil: genitiv_plural_beispiel!.beispiel_RU!, result: $nominativ_plural_correct)
                                }else{
                                    FlipCard(deutschesSeite: $genitiv_plural_deutschesSeite, deutschesWorte: genitiv_plural!.nomen_DE!, russischesWorte: genitiv_plural!.nomen_RU!, result: $genitiv_plural_correct)
                                }
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        genitiv_plural_correct = 1
                                    }
                                Image(systemName: "multiply.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        genitiv_plural_correct = -1
                                    }
                            }
                        }
                        if(akkusativ_plural != nil){
                            Divider()
                            Text("Akkusativ Plural")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            Text(akkusativ_plural_deutschesSeite ? "Wen? Was?" : "Кого? Что?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(akkusativ_plural_beispiel != nil){
                                    FlipCard(deutschesSeite: $akkusativ_plural_deutschesSeite, deutschesWorte: akkusativ_plural!.nomen_DE!, russischesWorte: akkusativ_plural!.nomen_RU!, deutschesBeispeil: akkusativ_plural_beispiel!.beispiel_DE!, russischesBeispeil: akkusativ_plural_beispiel!.beispiel_RU!, result: $akkusativ_plural_correct)
                                }else{
                                    FlipCard(deutschesSeite: $akkusativ_plural_deutschesSeite, deutschesWorte: akkusativ_plural!.nomen_DE!, russischesWorte: akkusativ_plural!.nomen_RU!, result: $akkusativ_plural_correct)
                                }
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        akkusativ_plural_correct = 1
                                    }
                                Image(systemName: "multiply.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        akkusativ_plural_correct = -1
                                    }
                            }
                        }
                        if(dativ_plural != nil){
                            Divider()
                            Text("Dativ Plural")
                                .NG_textStyling(.NG_TextStyle_Title, theme: theme)
                            Text(dativ_plural_deutschesSeite ? "Wem?" : "Кому? Чему?")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            HStack{
                                if(dativ_plural_beispiel != nil){
                                    FlipCard(deutschesSeite: $dativ_plural_deutschesSeite, deutschesWorte: dativ_plural!.nomen_DE!, russischesWorte: dativ_plural!.nomen_RU!, deutschesBeispeil: dativ_plural_beispiel!.beispiel_DE!, russischesBeispeil: dativ_plural_beispiel!.beispiel_RU!, result: $dativ_plural_correct)
                                }else{
                                    FlipCard(deutschesSeite: $dativ_plural_deutschesSeite, deutschesWorte: dativ_plural!.nomen_DE!, russischesWorte: dativ_plural!.nomen_RU!, result: $dativ_plural_correct)
                                }
                                Image(systemName: "checkmark.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        dativ_plural_correct = 1
                                    }
                                Image(systemName: "multiply.square.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                    .onTapGesture {
                                        dativ_plural_correct = -1
                                    }
                            }
                        }
                    }
                    .background(.clear)
                    .scrollIndicators(.hidden)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .NG_Card(.NG_CardStyle_Regular, theme: theme)
            .onAppear{
                pickTheWord()
            }
        }
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
    func pickTheWord() {
        pickedNomenHive = Statistics.pickNomenHive(viewContext)
        if pickedNomenHive != nil {
            exercisedWords.insert(pickedNomenHive!)
            
            nominativ_singular = Nomen.pick_nomenativ_singular(pickedNomenHive!)
            nominativ_singular_correct = nominativ_singular != nil ? 0 : 1
            nominativ_singular_deutschesSeite = false
            if(nominativ_singular != nil){
                nominativ_singular_beispiel = Nomen.get_beispiel(nominativ_singular!)
            }
            
            genitiv_singular = Nomen.pick_genitiv_singular(pickedNomenHive!)
            genitiv_singular_correct = genitiv_singular != nil ? 0 : 1
            genitiv_singular_deutschesSeite = false
            if(genitiv_singular != nil){
                genitiv_singular_beispiel = Nomen.get_beispiel(genitiv_singular!)
            }
            
            akkusativ_singular = Nomen.pick_akkusativ_singular(pickedNomenHive!)
            akkusativ_singular_correct = akkusativ_singular != nil ? 0 : 1
            akkusativ_singular_deutschesSeite = false
            if(akkusativ_singular != nil){
                akkusativ_singular_beispiel = Nomen.get_beispiel(akkusativ_singular!)
            }
            
            dativ_singular = Nomen.pick_dativ_singular(pickedNomenHive!)
            dativ_singular_correct = dativ_singular != nil ? 0 : 1
            dativ_singular_deutschesSeite = false
            if(dativ_singular != nil){
                dativ_singular_beispiel = Nomen.get_beispiel(dativ_singular!)
            }
            
            nominativ_plural = Nomen.pick_nomenativ_plural(pickedNomenHive!)
            nominativ_plural_correct = nominativ_plural != nil ? 0 : 1
            nominativ_plural_deutschesSeite = false
            if(nominativ_plural != nil){
                nominativ_plural_beispiel = Nomen.get_beispiel(nominativ_plural!)
            }
            
            genitiv_plural = Nomen.pick_genitiv_plural(pickedNomenHive!)
            genitiv_plural_correct = genitiv_plural != nil ? 0 : 1
            genitiv_plural_deutschesSeite = false
            if(genitiv_plural != nil){
                genitiv_plural_beispiel = Nomen.get_beispiel(genitiv_plural!)
            }
            
            akkusativ_plural = Nomen.pick_akkusativ_plural(pickedNomenHive!)
            akkusativ_plural_correct = akkusativ_plural != nil ? 0 : 1
            akkusativ_plural_deutschesSeite = false
            if(akkusativ_plural != nil){
                akkusativ_plural_beispiel = Nomen.get_beispiel(akkusativ_plural!)
            }
            
            dativ_plural = Nomen.pick_dativ_plural(pickedNomenHive!)
            dativ_plural_correct = dativ_plural != nil ? 0 : 1
            dativ_plural_deutschesSeite = false
            if(dativ_plural != nil){
                dativ_plural_beispiel = Nomen.get_beispiel(dativ_plural!)
            }
        }
    }
}
