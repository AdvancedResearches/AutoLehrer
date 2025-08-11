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
    @State var flippedSeite: [Bool] = []
    @State var missedGuess: [Bool] = []
    @State var flipScaleRatio: [CGFloat] = []
    @State var wortForm: [WortArtFormen] = []
    
    @State var exercisedWorte: Set<WortFormen> = []
    @State var confirmedWorte: Set<WortFormen> = []
    
    @State var readyToMoveOn: Bool = false
    
    @State var runningWort: Int = 0
    
    @State private var blur: CGFloat = 0
    @State private var scaleRatio: CGFloat = 1
    
    @State var attemptCounter: Int = 0
    
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
                            attemptCounter += 1
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
                            Statistics.wortFormenUrgency(pickedWortFormen!)
                            pickTheWord()
                        }else{
                            withAnimation(.easeOut(duration: 0.1)) { scaleRatio = 1.1 }
                            withAnimation(.easeOut(duration: 0.1).delay(0.1)) { scaleRatio = 1 }
                            withAnimation(.easeOut(duration: 0.1).delay(0.2)) { scaleRatio = 1.1 }
                            withAnimation(.easeOut(duration: 0.1).delay(0.3)) { scaleRatio = 1 }
                            withAnimation(.easeOut(duration: 0.1).delay(0.4)) { scaleRatio = 1.1 }
                            withAnimation(.easeOut(duration: 0.5).delay(0.5)) { scaleRatio = 1 }
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
                        result: $guessingResult[index],
                        condensed: !isCurrent
                    )
                    .scaleEffect(flipScaleRatio[index])
                    .onChange(of: deutschesSeite[index]){ value in
                        flippedSeite[index] = true
                    }
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
                        NG_Button(title: "Знал", style: .NG_ButtonStyle_Green, isDisabled: Binding(
                            get: {
                                !flippedSeite[index] || missedGuess[index]
                            },
                            set: { value in
                            }
                        ), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            if(flippedSeite[index] && !missedGuess[index]){
                                if(guessingResult[index] == 0){
                                    runningWort += 1
                                }
                                guessingResult[index] = 1
                                readyToMoveOn = guessingResult.allSatisfy { $0 != 0}
                            }
                        }, widthFlood: true)
                        NG_Button(title: "Не знал", style: .NG_ButtonStyle_Red, isDisabled: Binding(
                            get: {
                                !flippedSeite[index]
                            },
                            set: { value in
                                flippedSeite[index] = !value
                            }
                        ), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            if(flippedSeite[index]){
                                if(guessingResult[index] == 0){
                                    runningWort += 1
                                }
                                guessingResult[index] = -1
                                readyToMoveOn = guessingResult.allSatisfy { $0 != 0}
                            }
                        }, widthFlood: true)
                        Spacer()
                    }
                }
            }
            .if(isCurrent){ view in
                view.NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .scaleEffect(scaleRatio)
            }
            .if(!flippedSeite[index] && isCurrent){ view in
                view.onAppear{
                    let thisCertainCounter = attemptCounter
                    print("Initiate flipping for index \(index)")
                    withAnimation(.easeOut(duration: 0.3)) { flipScaleRatio[index] = 1.02 }
                    withAnimation(.easeOut(duration: 0.7).delay(0.3)) { flipScaleRatio[index] = 1 }
                    withAnimation(.easeOut(duration: 0.25).delay(1.0)) { flipScaleRatio[index] = 1.04 }
                    withAnimation(.easeOut(duration: 0.75).delay(1.25)) { flipScaleRatio[index] = 1 }
                    withAnimation(.easeOut(duration: 0.2).delay(2.0)) { flipScaleRatio[index] = 1.06 }
                    withAnimation(.easeOut(duration: 0.8).delay(2.2)) { flipScaleRatio[index] = 1 }
                    withAnimation(.easeOut(duration: 0.15).delay(3.0)) { flipScaleRatio[index] = 1.08 }
                    withAnimation(.easeOut(duration: 0.85).delay(3.15)) { flipScaleRatio[index] = 1 }
                    withAnimation(.easeOut(duration: 0.1).delay(4.0)) { flipScaleRatio[index] = 1.1 }
                    withAnimation(.easeOut(duration: 0.9).delay(4.1)) { flipScaleRatio[index] = 1 }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        if(attemptCounter == thisCertainCounter){
                            if(!flippedSeite[index]){
                                deutschesSeite[index] = true
                                flippedSeite[index] = true
                                missedGuess[index] = true
                            }
                        }
                    }
                }
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
        flippedSeite = []
        missedGuess = []
        flipScaleRatio = []
        guessingResult = []
        wortForm = []
        
        exercisedWorte.insert(pickedSache)
        
        let wortFormList = Array(WortFormen.get_wortFormenList_furArt(wortArt).prefix(Int(pickedSache.formsToShow)))
        
        wort = []
        beispiel = []
        
        for theCounter in 0..<wortFormList.count{
            let wortTest = Wort.pick_wort(pickedSache, wortArtFormen: wortFormList[theCounter])
            if(wortTest != nil){
                wort.append(wortTest!)
                beispiel.append(Wort.get_beispiel(wortTest!))
                wortForm.append(wortFormList[theCounter])
            }
        }
        
        deutschesSeite = Array(repeating: false, count: wort.count)
        flippedSeite = Array(repeating: false, count: wort.count)
        missedGuess = Array(repeating: false, count: wort.count)
        flipScaleRatio = Array(repeating: 1, count: wort.count)
        guessingResult = Array(repeating: 0, count: wort.count)
        readyToMoveOn = false
        runningWort = 0
        pickedWortFormen = pickedSache
    }
}
