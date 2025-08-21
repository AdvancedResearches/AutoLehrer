import SwiftUI
import CoreData

struct DualColorBar: View {
    var greenvalue: Double   // 0...1
    var yellowvalue: Double  // где меняется цвет
    var height: CGFloat = 25
    @Binding var pulseyellowtogreen: Bool
    @State private var pulsation = false

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                
                // Жёлтая часть
                Rectangle()
                    .fill(pulsation ? Color.green : Color.yellow)
                    .frame(width: geo.size.width * CGFloat(yellowvalue))
                    .animation(pulseyellowtogreen
                               ? .linear(duration: 0.5).repeatForever(autoreverses: true)
                                           : .default,
                                           value: pulsation)
                    .task(id: pulseyellowtogreen) {
                        if pulseyellowtogreen {
                            // Сначала сброс...
                            pulsation = false
                            // ...и старт цикла (repeatForever привяжется к ЭТОМУ изменению)
                            withAnimation { pulsation = true }
                        } else {
                            // Чётко гасим без анимации, чтобы остановить «на месте»
                            withAnimation(nil) { pulsation = false }
                        }
                    }

                // Зелёная часть
                Rectangle()
                    .fill(Color.green)
                    .frame(width: geo.size.width * CGFloat(greenvalue))
            }
            .onChange(of: pulseyellowtogreen){ old, new in
                print("DualColorBar.pulseyellowtogreen: \(old) -> \(new)")
            }
            .onAppear{
                print("DualColorBar.pulseyellowtogreen: \(pulseyellowtogreen)")
            }
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: height/2))
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizeAware<Content: View>: View {
    let onChange: (CGSize) -> Void
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geo.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct WortRepeater: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    
    var wortArt: WortArt
    
    @State var pickedWortFormen: WortFormen?
    
    @State var hasFaults: Bool = false
    @State var guessingResult: [Int] = []
    @State var wort: [Wort] = []
    @State var beispiel: [Beispiel?] = []
    @State var deutschesSeite: [Bool] = []
    @State var flippedSeite: [Bool] = []
    @State var missedGuess: [Bool] = []
    @State var flipScaleRatio: [CGFloat] = []
    @State var flipTimers: [Timer?] = []
    @State var flipTotal: [Double] = []
    @State var flipPassed: [Double] = []
    @State var flipCompleted: [Bool] = []
    @State var flipShakingRatio: [CGFloat] = []
    @State var wortForm: [WortArtFormen] = []
    
    @State var exercisedWorte: Set<WortFormen> = []
    @State var confirmedWorte: Set<WortFormen> = []
    
    @State var readyToMoveOn: Bool = false
    
    @State var runningWort: Int = 0
    
    @State private var blur: CGFloat = 0
    @State private var scaleRatio: CGFloat = 1
    
    @State var attemptCounter: Int = 0
    
    @State var potentiallyAddWortForme: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Text("В этой сессии пробовали \(exercisedWorte.count) слов. Из них выучено \(confirmedWorte.count).")
                    .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                    .padding(.horizontal, 5)
                Spacer()
            }
            VStack {
                if(pickedWortFormen != nil){
                    dasProgressSektion()
                }
                if(pickedWortFormen != nil){
                    ScrollViewReader { proxy in
                        ScrollView(.vertical, showsIndicators: true){
                            ForEach(Array(wort.enumerated()), id: \.element.objectID) { index, dasWort in
                                dasWortSektion(dasWort: dasWort, index: index)
                                    .id(index)
                                    .if(index > runningWort){ view in
                                        view.opacity(0.2)
                                    }
                            }
                            if(readyToMoveOn){
                                SizeAware(onChange: { _ in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        withAnimation(.easeInOut(duration: 1.0)) {
                                                proxy.scrollTo("bottom-anchor", anchor: .bottom)
                                            }
                                        }
                                }) {
                                    VStack{
                                        let successFormen = guessingResult.filter{$0 == 1}.count
                                        let checkedFormen = guessingResult.count
                                        let totalFormen = WortFormen.alleFormen(pickedWortFormen!)
                                        NG_Button(
                                            title: "Дальше (\(successFormen)/\(checkedFormen) было правильно)".localized(for: language),
                                            style: successFormen==checkedFormen ? .NG_ButtonStyle_Green : .NG_ButtonStyle_Red,
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
                                        .padding(.horizontal, 15)
                                        .padding(.vertical, 25)
                                        .transition(.scale)
                                        
                                        HStack{
                                            Text("Всего форм: \(totalFormen)")
                                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                            Spacer()
                                        }
                                        HStack{
                                            Text("Проверено форм: \(checkedFormen)")
                                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                            Spacer()
                                        }
                                        HStack{
                                            Text("Правильно отмечено форм: \(successFormen)")
                                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                            Spacer()
                                        }
                                        if(successFormen < checkedFormen){
                                            //Не всё правильно отвечено
                                            if(checkedFormen < totalFormen){
                                                //Не всё правильно отвечено - Не все ещё формы проверены
                                                HStack{
                                                    Text("Не все формы были правильно отвечены. Поэтому надо будет ответить ещё 3 раза правильно все формы чтобы добавить ещё одну форму для проверки.")
                                                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                    Spacer()
                                                }
                                                HStack{
                                                    Text("Слово будет засчитано как заученное только после подтверждения всех форм!")
                                                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                    Spacer()
                                                }
                                            }else{
                                                //Не всё правильно отвечено - Все формы проверены
                                                HStack{
                                                    Text("Не все формы были правильно отвечены. Поэтому надо будет ответить ещё 3 раза правильно все формы чтобы это слово зачлось как изученное.")
                                                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                    Spacer()
                                                }
                                                HStack{
                                                    Text("Слово будет засчитано как заученное только после подтверждения всех форм!")
                                                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                    Spacer()
                                                }
                                            }
                                        }else{
                                            //Всё правильно отвечено
                                            if(checkedFormen < totalFormen){
                                                //Всё правильно отвечено - Не все ещё формы проверены
                                                if(WortFormen.repetitionsToAddNewForm(pickedWortFormen!) <= 0){
                                                    //Всё правильно отвечено - Не все ещё формы проверены - пора добавить ещё одну форму
                                                    HStack{
                                                        Text("Все формы были помечены как правильные. Добавляем ещё одну форму для проверки.")
                                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        Text("Слово будет засчитано как заученное только после подтверждения всех форм!")
                                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                        Spacer()
                                                    }
                                                }else{
                                                    //Всё правильно отвечено - Не все ещё формы проверены - рано добавить ещё одну форму
                                                    HStack{
                                                        Text("Все формы были помечены как правильные. Нужно ответить правильно на все формы ещё \(WortFormen.repetitionsToAddNewForm(pickedWortFormen!)) раз(а) чтобы добавить ещё одну форму для проверки.")
                                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        Text("Слово будет засчитано как заученное только после подтверждения всех форм!")
                                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                        Spacer()
                                                    }
                                                }
                                            }else{
                                                //Всё правильно отвечено - Все формы проверены
                                                if(WortFormen.repetitionsToAddNewForm(pickedWortFormen!) <= 0){
                                                    //Всё правильно отвечено - Все формы проверены - пора добавить ещё одну форму
                                                    HStack{
                                                        Text("Все формы были помечены как правильные. Поздравляю! Слово выучено!")
                                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                        Spacer()
                                                    }
                                                }else{
                                                    //Всё правильно отвечено - Все формы проверены - рано добавить ещё одну форму
                                                    HStack{
                                                        Text("Все формы были помечены как правильные. Нужно ответить правильно на все формы ещё \(WortFormen.repetitionsToAddNewForm(pickedWortFormen!)) раз(а) чтобы слово считалось выученым.")
                                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        Text("Слово будет засчитано как заученное только после подтверждения всех форм!")
                                                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                        Spacer()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Color.clear.frame(height: 1).id("bottom-anchor")
                        }
                        .background(.clear)
                        .animation(.easeInOut(duration: 0.35), value: readyToMoveOn)
                        .onChange(of: runningWort) { newValue in
                            withAnimation {
                                proxy.scrollTo(newValue, anchor: .center)
                            }
                        }
                        .onChange(of: flippedSeite) { newValue in
                            withAnimation {
                                proxy.scrollTo(runningWort, anchor: .center)
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
    private func dasProgressSektion() -> some View {
        return HStack{
            DualColorBar(
                greenvalue: WortFormen.succeededFormenRatio(pickedWortFormen!),
                yellowvalue: WortFormen.attemptingFormenRatio(pickedWortFormen!),
                height: 25,
                pulseyellowtogreen: $potentiallyAddWortForme
            )
            .onAppear{
                potentiallyAddWortForme = (!pickedWortFormen!.failed) || (pickedWortFormen!.failed && pickedWortFormen!.successCounter >= 2)
                print("Initialize potential word form add - pulse to \(potentiallyAddWortForme)")
            }
            .onChange(of: hasFaults){ _, newValue in
                if(newValue){
                    potentiallyAddWortForme = false
                    print("Discard potential word form add - pulse false")
                }else{
                    potentiallyAddWortForme = (!pickedWortFormen!.failed) || (pickedWortFormen!.failed && pickedWortFormen!.successCounter >= 2)
                    print("Reset potential word form add - pulse to \(potentiallyAddWortForme)")
                }
            }
            if(!pickedWortFormen!.failed){
                Image(systemName: "questionmark.square.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                    .font(.system(size: 25))
                Image(systemName: "questionmark.square.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                    .font(.system(size: 25))
                Image(systemName: "questionmark.square.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                    .font(.system(size: 25))
            }else{
                if(pickedWortFormen!.successCounter == 0){
                    Image(systemName: "questionmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                        .font(.system(size: 25))
                    Image(systemName: "square")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .clear)
                        .font(.system(size: 25))
                    Image(systemName: "square")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .clear)
                        .font(.system(size: 25))
                }
                if(pickedWortFormen!.successCounter == 1){
                    Image(systemName: "checkmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, guessingResult.contains(-1) ? .red : .green)
                        .font(.system(size: 25))
                    Image(systemName: "questionmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                        .font(.system(size: 25))
                    Image(systemName: "square")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, .clear)
                        .font(.system(size: 25))
                }
                if(pickedWortFormen!.successCounter == 2){
                    Image(systemName: "checkmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, guessingResult.contains(-1) ? .red : .green)
                        .font(.system(size: 25))
                    Image(systemName: "checkmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, guessingResult.contains(-1) ? .red : .green)
                        .font(.system(size: 25))
                    Image(systemName: "questionmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                        .font(.system(size: 25))
                }
                if(pickedWortFormen!.successCounter >= 3){
                    Image(systemName: "checkmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, guessingResult.contains(-1) ? .red : .green)
                        .font(.system(size: 25))
                    Image(systemName: "checkmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, guessingResult.contains(-1) ? .red : .green)
                        .font(.system(size: 25))
                    Image(systemName: "checkmark.square.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black, guessingResult.contains(-1) ? .red : .green)
                        .font(.system(size: 25))
                }
            }
        }
        
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
                        condensed: !isCurrent,
                        elapsedTime: $flipTotal[index],
                        passedTime: $flipPassed[index],
                        completed: $flipCompleted[index],
                        notStarted: Binding(get: {
                            return !isCurrent && !hasPassed
                        }, set: { value in}
                                           )
                    )
                    .scaleEffect(flipScaleRatio[index])
                    .scaleEffect(flipShakingRatio[index])
                    .onChange(of: deutschesSeite[index]){ value in
                        flippedSeite[index] = true
                    }
                    if(hasPassed){
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
                                hasFaults = guessingResult.contains(-1)
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
                                hasFaults = guessingResult.contains(-1)
                            }
                    }
                }
                if(isCurrent && flippedSeite[index]){
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
                            }else{
                                if(!flippedSeite[index]){
                                    withAnimation(.easeOut(duration: 0.05)) { flipShakingRatio[index] = 1.05 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.05)) { flipShakingRatio[index] = 0.95 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.1)) { flipShakingRatio[index] = 1.05 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.15)) { flipShakingRatio[index] = 0.95 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.2)) { flipShakingRatio[index] = 1.05 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.25)) { flipShakingRatio[index] = 0.95 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.3)) { flipShakingRatio[index] = 1.05 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.35)) { flipShakingRatio[index] = 0.95 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.4)) { flipShakingRatio[index] = 1.05 }
                                    withAnimation(.easeOut(duration: 0.05).delay(0.45)) { flipShakingRatio[index] = 1 }
                                }
                            }
                            hasFaults = guessingResult.contains(-1)
                        }, widthFlood: true)
                        .if((!flippedSeite[index])||(missedGuess[index])){ view in
                            view.opacity(0.0)
                        }
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
                            }else{
                                withAnimation(.easeOut(duration: 0.05)) { flipShakingRatio[index] = 1.05 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.05)) { flipShakingRatio[index] = 0.95 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.1)) { flipShakingRatio[index] = 1.05 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.15)) { flipShakingRatio[index] = 0.95 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.2)) { flipShakingRatio[index] = 1.05 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.25)) { flipShakingRatio[index] = 0.95 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.3)) { flipShakingRatio[index] = 1.05 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.35)) { flipShakingRatio[index] = 0.95 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.4)) { flipShakingRatio[index] = 1.05 }
                                withAnimation(.easeOut(duration: 0.05).delay(0.45)) { flipShakingRatio[index] = 1 }
                            }
                            hasFaults = guessingResult.contains(-1)
                        }, widthFlood: true)
                        .if(!flippedSeite[index]){ view in
                            view.opacity(0.0)
                        }
                        Spacer()
                    }
                }
            }
            .if(isCurrent){ view in
                view.NG_Card(.NG_CardStyle_Regular, noShadow: true, theme: theme)
                    .scaleEffect(scaleRatio)
            }
            .if(!flippedSeite[index] && isCurrent){ view in
                view.onAppear{
                    let thisCertainCounter = attemptCounter
                    print("Initiate flipping for index \(index)")
                    
                    flipTimers[index]?.invalidate()
                    flipTotal[index] = 5.0
                    flipPassed[index] = 0.0
                    flipCompleted[index] = false
                    
                    flipTimers[index] = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ t in
                        if attemptCounter != thisCertainCounter || flippedSeite[index] {
                            t.invalidate()
                            flipTimers[index] = nil
                            return
                        }
                        
                        flipPassed[index] += 0.1
                        
                        if flipPassed[index] >= flipTotal[index] {
                            flipCompleted[index] = true
                            
                            t.invalidate()
                            flipTimers[index] = nil
                        }
                    }
                    
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
                .onDisappear{
                    flipTimers[index]?.invalidate()
                    flipTimers[index] = nil
                }
            }
        }
    }
    func pickTheWord() {
        let pickedSache = Statistics.pickWortFormen(viewContext, wortArt: wortArt)
        print("WortRepeater.pickTheWord(): picked sache: \(pickedSache.relWortArt!.name_DE!)-\(pickedSache.wortFrequencyOrder)")
        
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
        
        wort = []
        beispiel = []
        
        print("WortRepeater.pickTheWord(): pickedSache.formsToShow: \(pickedSache.formsToShow)")
        
        var appendedCount = 0
        
        var theCounter = 0
        
        var alleWorteFurSache = pickedSache.relWort?.allObjects as! [Wort] ?? []
        
        var sortedWorte = Wort.Worte_sort(alleWorteFurSache, pickedSache.relWortArt!)
        
        var topWorte: [Wort] = Array(sortedWorte.prefix(Int(pickedSache.formsToShow)))
        
        for theCounter in 0..<topWorte.count{
            wort.append(topWorte[theCounter])
            beispiel.append(Wort.get_beispiel(topWorte[theCounter]))
            wortForm.append(WortArtFormen.fromWort(topWorte[theCounter]))
        }
        
        print("WortRepeater.pickTheWord(): wort.count: \(wort.count)")
        
        deutschesSeite = Array(repeating: false, count: wort.count)
        flippedSeite = Array(repeating: false, count: wort.count)
        missedGuess = Array(repeating: false, count: wort.count)
        flipScaleRatio = Array(repeating: 1, count: wort.count)
        flipTimers = Array(repeating: nil, count: wort.count)
        flipPassed = Array(repeating: 0, count: wort.count)
        flipTotal = Array(repeating: 5.0, count: wort.count)
        flipCompleted = Array(repeating: false, count: wort.count)
        flipShakingRatio = Array(repeating: 1, count: wort.count)
        guessingResult = Array(repeating: 0, count: wort.count)
        readyToMoveOn = false
        runningWort = 0
        hasFaults = false
        pickedWortFormen = pickedSache
        potentiallyAddWortForme = (!pickedWortFormen!.failed) || (pickedWortFormen!.failed && pickedWortFormen!.successCounter >= 2)
    }
}
