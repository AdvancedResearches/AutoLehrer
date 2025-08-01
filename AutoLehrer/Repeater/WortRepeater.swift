import SwiftUI
import CoreData

struct WortRepeater: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    
    var wortArt: WortArt
    
    @State var pickedWortFormen: WortFormen?
    
    @State var guessingResult: [Int] = []
    @State var wort: [Wort] = []
    @State var beispiel: [Beispiel?] = []
    @State var deutschesSeite: [Bool] = []
    @State var wortForm: [WortArtFormen] = []
    
    @State var exercisedWorte: Set<WortFormen> = []
    @State var confirmedWorte: Set<WortFormen> = []
    
    var body: some View {
        VStack{
            HStack{
                Text("Выучено слов \(confirmedWorte.count) из \(exercisedWorte.count)")
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
                        var successCounter: Int = 0
                        for theFormCounter in 0..<wort.count{
                            if(guessingResult[theFormCounter] == 1){
                                Statistics.set_success(wort[theFormCounter])
                                successCounter += 1
                            }
                            if(guessingResult[theFormCounter] == -1){
                                Statistics.set_failure(wort[theFormCounter])
                            }
                        }
                        if(successCounter == wort.count){
                            if(WortFormen.set_success(pickedWortFormen!)){
                                confirmedWorte.insert(pickedWortFormen!)
                            }
                        }else{
                            WortFormen.set_failure(pickedWortFormen!)
                            confirmedWorte.remove(pickedWortFormen!)
                        }
                        WortFormen.set_attempted(pickedWortFormen!)
                        pickTheWord()
                    },
                    widthFlood: true
                )
                if(pickedWortFormen != nil){
                    HStack{
                        Text("Правильно \(pickedWortFormen!.successCounter) раз подряд")
                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        Spacer()
                    }
                }
                if(pickedWortFormen != nil){
                        ScrollView(.vertical){
                            ForEach(Array(wort.enumerated()), id: \.element.objectID) { index, derWort in
                                //let index = wort.firstIndex(where: { $0.id == derWort.id })!
                                
                                Divider()
                                HStack{
                                    if(WortFormen.get_wortArt_string(pickedWortFormen!) == "Nomen"){
                                        let spracheWahlen = deutschesSeite[index] ? "DE" : "RU"
                                        Text(Wort.get_wortArt_vollString(wort[index], spracheWahlen))
                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                        Text(Wort.get_wortArt_auxString(wort[index], spracheWahlen))
                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    }
                                    
                                    Image(systemName: "checkmark.square.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                        .onTapGesture {
                                            guessingResult[index] = 1
                                        }
                                    Image(systemName: "multiply.square.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                                        .onTapGesture {
                                            guessingResult[index] = -1
                                        }
                                }
                            }
                            
                            /*
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
                             */
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
        let pickedSache = Statistics.pickWortFormen(viewContext, wortArt: wortArt)
        
        pickedWortFormen = nil
        wort = []
        beispiel = []
        deutschesSeite = []
        guessingResult = []
        wortForm = []
        
        exercisedWorte.insert(pickedSache)
        
        let wortFormList = WortFormen.get_wortFormenList_furArt(wortArt)
        
        wort = []
        beispiel = []
        
        for theCounter in 0..<wortFormList.count{
            let wortTest = Wort.pick_wort(pickedSache, genus: wortFormList[theCounter].genus, kasus: wortFormList[theCounter].kasus, modus: wortFormList[theCounter].modus, numerus: wortFormList[theCounter].numerus, person: wortFormList[theCounter].person, tempus: wortFormList[theCounter].tempus)
            if(wortTest != nil){
                wort.append(wortTest!)
                beispiel.append(Wort.get_beispiel(wortTest!))
                wortForm.append(wortFormList[theCounter])
            }
        }
        
        deutschesSeite = Array(repeating: false, count: wort.count)
        guessingResult = Array(repeating: 0, count: wort.count)
        pickedWortFormen = pickedSache
    }
}
