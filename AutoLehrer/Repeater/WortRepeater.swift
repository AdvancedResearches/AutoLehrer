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
                                //if(WortFormen.get_wortArt_string(pickedWortFormen!) == "Nomen"){
                                    let spracheWahlen = deutschesSeite[index] ? "DE" : "RU"
                                    Text(Wort.get_wortArt_vollString(wort[index], spracheWahlen))
                                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    Text(Wort.get_wortArt_auxString(wort[index], spracheWahlen))
                                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                //}
                                HStack{
                                    FlipCard(
                                        deutschesSeite: $deutschesSeite[index],
                                        deutschesWorte: derWort.wort_DE!,
                                        russischesWorte: derWort.wort_RU!,
                                        deutschesBeispeil: beispiel[index]?.beispiel_DE ?? nil,
                                        russischesBeispeil: beispiel[index]?.beispiel_RU ?? nil,
                                        result: $guessingResult[index]
                                    )
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
        
        if (pickedSache.formsToShow < 1){
            pickedSache.formsToShow = 1
        }
        
        pickedWortFormen = nil
        wort = []
        beispiel = []
        deutschesSeite = []
        guessingResult = []
        wortForm = []
        
        exercisedWorte.insert(pickedSache)
        
        let wortFormList = Array(WortFormen.get_wortFormenList_furArt(wortArt).prefix(Int(pickedSache.formsToShow)))
        
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
