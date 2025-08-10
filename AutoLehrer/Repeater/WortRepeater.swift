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
    
    @State var readyToMoveOn: Bool = false
    
    @State var runningWort: Int = 0
    
    @State private var blur: CGFloat = 0
    
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
                    isDisabled: .init(
                        get: { !readyToMoveOn },
                        set: { readyToMoveOn = !$0 }
                    ),
                    isHighlighting: .constant(false),
                    isPulsating: .constant(readyToMoveOn),
                    action: {
                        if(readyToMoveOn){
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
                        }else{
                            withAnimation(.easeInOut(duration: 0.12)) { blur = 6 }
                            withAnimation(.easeOut(duration: 0.88).delay(0.12)) { blur = 0 }
                        }
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
                    ScrollViewReader { proxy in
                        ScrollView(.vertical, showsIndicators: true){
                            ForEach(Array(wort.enumerated()), id: \.element.objectID) { index, dasWort in
                                dasWortSektion(dasWort: dasWort, index: index)
                                    .id(index)
                            }
                        }
                        .background(.clear)
                        .onChange(of: runningWort) { newValue in
                            withAnimation {
                                proxy.scrollTo(newValue, anchor: .center) // или .top, если надо к началу
                            }
                        }
                    }
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
    
    private func dasWortSektion(dasWort: Wort, index: Int) -> some View {
        let spracheWahlen = deutschesSeite[index] ? "DE" : "RU"
        let hasPassed = index < runningWort
        let isCurrent = index == runningWort
        return Group{
            Divider()
            VStack{
            Text(Wort.get_wortArt_vollString(wort[index], spracheWahlen))
                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
            Text(Wort.get_wortArt_auxString(wort[index], spracheWahlen))
                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                HStack{
                    FlipCard(
                        deutschesSeite: $deutschesSeite[index],
                        deutschesWorte: dasWort.wort_DE!,
                        russischesWorte: dasWort.wort_RU!,
                        deutschesBeispeil: beispiel[index]?.beispiel_DE ?? nil,
                        russischesBeispeil: beispiel[index]?.beispiel_RU ?? nil,
                        result: $guessingResult[index]
                    )
                    if(!isCurrent){
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .NG_iconStyling(hasPassed ? .NG_IconStyle_Green : .NG_IconStyle_Disabled, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                            .onTapGesture {
                                if(hasPassed){
                                    if(guessingResult[index] == 0){
                                        runningWort += 1
                                    }
                                    guessingResult[index] = 1
                                    readyToMoveOn = guessingResult.allSatisfy { $0 != 0}
                                }
                            }
                        Image(systemName: "multiply.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .NG_iconStyling(hasPassed ? .NG_IconStyle_Red : .NG_IconStyle_Disabled, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                            .onTapGesture {
                                if(hasPassed){
                                    if(guessingResult[index] == 0){
                                        runningWort += 1
                                    }
                                    guessingResult[index] = -1
                                    readyToMoveOn = guessingResult.allSatisfy { $0 != 0}
                                }
                            }
                    }
                }
                if(isCurrent){
                    HStack{
                        Spacer()
                        NG_Button(title: "Знал", style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            if(guessingResult[index] == 0){
                                runningWort += 1
                            }
                            guessingResult[index] = 1
                            readyToMoveOn = guessingResult.allSatisfy { $0 != 0}
                        })
                        Spacer()
                        NG_Button(title: "Не знал", style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            if(guessingResult[index] == 0){
                                runningWort += 1
                            }
                            guessingResult[index] = -1
                            readyToMoveOn = guessingResult.allSatisfy { $0 != 0}
                        })
                        Spacer()
                    }
                }
            }
            .if(isCurrent){ view in
                view.NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .blur(radius: blur)
            }
        }
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
            //print("picking wort for \(wortFormList[theCounter].debug_string())")
            let wortTest = Wort.pick_wort(pickedSache, /*genus: wortFormList[theCounter].genus, kasus: wortFormList[theCounter].kasus, modus: wortFormList[theCounter].modus, numerus: wortFormList[theCounter].numerus, person: wortFormList[theCounter].person, tempus: wortFormList[theCounter].tempus*/ wortArtFormen: wortFormList[theCounter])
            if(wortTest != nil){
                wort.append(wortTest!)
                beispiel.append(Wort.get_beispiel(wortTest!))
                wortForm.append(wortFormList[theCounter])
            }
        }
        
        deutschesSeite = Array(repeating: false, count: wort.count)
        guessingResult = Array(repeating: 0, count: wort.count)
        readyToMoveOn = false
        runningWort = 0
        pickedWortFormen = pickedSache
    }
}
