import SwiftUI
import CoreData

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
    @State var flipTimers: [PausableTimer?] = []
    @State var flipTotal: [Double] = []
    @State var flipPassed: [Double] = []
    @State var flipTicker: [Int] = []
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
    
    @State var showProgressBarDetails: Bool = false
    
    @State var showDailyWortArtAnnouncement: Bool = false
    @State var showAverageWortArtAnnouncement: Bool = false
    @State var showDailyAnnouncement: Bool = false
    @State var showAverageAnnouncement: Bool = false
    
    @State private var timeAttackMode: Int = -1
    
    var body: some View {
        VStack{
            HStack{
                Text("В этой сессии: опробовано слов: \(exercisedWorte.count) / из них выучено: \(confirmedWorte.count)")
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
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
                                        withAnimation(.easeInOut(duration: 0.35)) {
                                            proxy.scrollTo("bottom-anchor", anchor: .bottom)
                                        }
                                    }
                                }) {
                                    let successFormen = guessingResult.filter{$0 == 1}.count
                                    let checkedFormen = guessingResult.count
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
            .onChange(of: showProgressBarDetails){ oldValue, newValue in
                if(newValue){
                    if(runningWort < flipTimers.count){
                        guard let timer = flipTimers[runningWort] else {return}
                        timer.pause()
                    }
                }else{
                    if(runningWort < flipTimers.count){
                        if(!flippedSeite[runningWort]){
                            guard let timer = flipTimers[runningWort] else {return}
                            timer.resume()
                        }
                    }
                }
            }
            .onChange(of: showDailyAnnouncement){ oldValue, newValue in
                if(newValue){
                    if(runningWort < flipTimers.count){
                        guard let timer = flipTimers[runningWort] else {return}
                        timer.pause()
                    }
                }else{
                    if(runningWort < flipTimers.count){
                        if(!flippedSeite[runningWort]){
                            guard let timer = flipTimers[runningWort] else {return}
                            timer.resume()
                        }
                    }
                }
            }
            .onChange(of: showAverageAnnouncement){ oldValue, newValue in
                if(newValue){
                    if(runningWort < flipTimers.count){
                        guard let timer = flipTimers[runningWort] else {return}
                        timer.pause()
                    }
                }else{
                    if(runningWort < flipTimers.count){
                        if(!flippedSeite[runningWort]){
                            guard let timer = flipTimers[runningWort] else {return}
                            timer.resume()
                        }
                    }
                }
            }
            .onChange(of: showDailyWortArtAnnouncement){ oldValue, newValue in
                if(newValue){
                    if(runningWort < flipTimers.count){
                        guard let timer = flipTimers[runningWort] else {return}
                        timer.pause()
                    }
                }else{
                    if(runningWort < flipTimers.count){
                        if(!flippedSeite[runningWort]){
                            guard let timer = flipTimers[runningWort] else {return}
                            timer.resume()
                        }
                    }
                }
            }
            .onChange(of: showAverageWortArtAnnouncement){ oldValue, newValue in
                if(newValue){
                    if(runningWort < flipTimers.count){
                        guard let timer = flipTimers[runningWort] else {return}
                        timer.pause()
                    }
                }else{
                    if(runningWort < flipTimers.count){
                        if(!flippedSeite[runningWort]){
                            guard let timer = flipTimers[runningWort] else {return}
                            timer.resume()
                        }
                    }
                }
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
        .sheet(isPresented: $showProgressBarDetails){
            dasProgressErklarung()
                .padding(.horizontal, 10)
                .NG_sheetFormatting(transparent: true)
                .padding(.horizontal, 10)
        }
        .sheet(isPresented: $showDailyWortArtAnnouncement){
            dailyWortArtHorrayAnnouncement()
                .padding(.horizontal, 10)
                .NG_sheetFormatting(transparent: true)
                .padding(.horizontal, 10)
        }
        .sheet(isPresented: $showDailyAnnouncement){
            dailyHorrayAnnouncement()
                .padding(.horizontal, 10)
                .NG_sheetFormatting(transparent: true)
                .padding(.horizontal, 10)
        }
        .sheet(isPresented: $showAverageWortArtAnnouncement){
            averageWortArtHorrayAnnouncement()
                .padding(.horizontal, 10)
                .NG_sheetFormatting(transparent: true)
                .padding(.horizontal, 10)
        }
        .sheet(isPresented: $showAverageAnnouncement){
            averageHorrayAnnouncement()
                .padding(.horizontal, 10)
                .NG_sheetFormatting(transparent: true)
                .padding(.horizontal, 10)
        }
        .onAppear(){
            timeAttackMode = Int(Settings.getTimeAttackMode(in: viewContext))
        }
    }
    private func dailyWortArtHorrayAnnouncement() -> some View{
        VStack{
            HStack{
                let stats = TimeStatistics.fetchLearningTime(in: viewContext, at: Date.now.stripTime(), forThe: pickedWortFormen!.relWortArt)
                if(stats != nil){
                    let spentMinutes: Int = Int(stats!.learningTime / 60)
                    let spentSeconds: Int = Int(stats!.learningTime - Double(spentMinutes*60))
                    Text("Сегодня на изучение этой группы слов потрачено уже больше, чем вчера - \(spentMinutes) минут \(spentSeconds) секунд!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }else{
                    Text("Сегодня на изучение этой группы слов потрачено уже больше, чем вчера!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }
                Spacer()
            }
            
            NG_Button(title: "Ура!", style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                TimeStatistics.hasAnnouncedAboveYesterday(in: viewContext, forThe: pickedWortFormen!.relWortArt)
                showDailyWortArtAnnouncement = false
            }, widthFlood: true)
        }
    }
    private func averageWortArtHorrayAnnouncement() -> some View{
        VStack{
            HStack{
                let stats = TimeStatistics.fetchLearningTime(in: viewContext, at: Date.now.stripTime(), forThe: pickedWortFormen!.relWortArt)
                if(stats != nil){
                    let spentMinutes: Int = Int(stats!.learningTime / 60)
                    let spentSeconds: Int = Int(stats!.learningTime - Double(spentMinutes*60))
                    Text("Сегодня на изучение этой группы слов потрачено уже больше, чем в среднем за неделю - \(spentMinutes) минут \(spentSeconds) секунд!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }else{
                    Text("Сегодня на изучение этой группы слов потрачено уже больше, чем в среднем за неделю!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }
                Spacer()
            }
            
            NG_Button(title: "Ура!", style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                TimeStatistics.hasAnnouncedAboveAverage(in: viewContext, forThe: pickedWortFormen!.relWortArt)
                showAverageWortArtAnnouncement = false
            }, widthFlood: true)
        }
    }
    private func dailyHorrayAnnouncement() -> some View{
        VStack{
            HStack{
                let stats = TimeStatistics.fetchLearningTime(in: viewContext, at: Date.now.stripTime(), forThe: pickedWortFormen!.relWortArt)
                if(stats != nil){
                    let spentMinutes: Int = Int(stats!.learningTime / 60)
                    let spentSeconds: Int = Int(stats!.learningTime - Double(spentMinutes*60))
                    Text("Сегодня на изучение в целом потрачено уже больше, чем вчера - \(spentMinutes) минут \(spentSeconds) секунд!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }else{
                    Text("Сегодня на изучение в целом потрачено уже больше, чем вчера!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }
                Spacer()
            }
            
            NG_Button(title: "Ура!", style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                TimeStatistics.hasAnnouncedAboveYesterday(in: viewContext, forThe: nil)
                showDailyAnnouncement = false
            }, widthFlood: true)
        }
    }
    private func averageHorrayAnnouncement() -> some View{
        VStack{
            HStack{
                let stats = TimeStatistics.fetchLearningTime(in: viewContext, at: Date.now.stripTime(), forThe: pickedWortFormen!.relWortArt)
                if(stats != nil){
                    let spentMinutes: Int = Int(stats!.learningTime / 60)
                    let spentSeconds: Int = Int(stats!.learningTime - Double(spentMinutes*60))
                    Text("Сегодня на изучение в целом потрачено уже больше, чем в среднем за неделю - \(spentMinutes) минут \(spentSeconds) секунд!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }else{
                    Text("Сегодня на изучение в целом потрачено уже больше, чем в среднем за неделю!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                }
                Spacer()
            }
            
            NG_Button(title: "Ура!", style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                TimeStatistics.hasAnnouncedAboveAverage(in: viewContext, forThe: nil)
                showAverageAnnouncement = false
            }, widthFlood: true)
        }
    }
    private func dasProgressErklarung() -> some View{
        VStack{
            HStack{
                Text("Всего форм у этого слова: \(WortFormen.alleFormen(pickedWortFormen!))")
                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                Spacer()
            }
            HStack{
                Text("Сейчас предлагается: \(pickedWortFormen!.formsToShow)")
                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                Spacer()
            }
            HStack{
                Text("Отмечено как известное: \(guessingResult.filter{$0 == 1}.count)")
                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                Spacer()
            }
            HStack{
                Text("Отмечено как неизвестное: \(guessingResult.filter{$0 == -1}.count)")
                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                Spacer()
            }
            
            Divider()
            
            let fasttrack = !pickedWortFormen!.failed
            let gamepoint = pickedWortFormen!.formsToShow == WortFormen.alleFormen(pickedWortFormen!)
            let allAnswered = !guessingResult.contains(0)
            let hasFaults = guessingResult.contains(-1)
            let matchpoint = fasttrack ? true : pickedWortFormen!.successCounter >= 2
            
            if(fasttrack){
                HStack{
                    Text("Этот набор форм слова предлагается впервые. Достаточно с первого раза перевести всё правильно чтобы этот набор форм слова считался изученным!")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                    Spacer()
                }
            }else{
                HStack{
                    Text("Ранее в этом наборе форм слова были ошибки. Чтобы этот набор форм слова считался изученным надо подтвердить знания 3 раза.")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        .padding(.bottom, 10)
                    Spacer()
                }
                HStack{
                    Text("До этой попытки было правильно переведено подряд раз: \(pickedWortFormen!.successCounter)")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                    Spacer()
                }
            }
            
            Divider()
            
            if allAnswered{
                if hasFaults{
                    HStack{
                        Text("Были ошибки. Придётся позже попробовать ещё раз.")
                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            .padding(.bottom, 10)
                        Spacer()
                    }
                }else{
                    if(gamepoint){
                        if(matchpoint){
                            HStack{
                                Text("Ошибок не было! Поздравляю! Слово засчитано как изученное!")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }else{
                            HStack{
                                Text("Ошибок не было! Но так как ранее в этом наборе были ошибки придётся подтвердить что ты точно знаешь это слово позже правильным переводом ещё \(3-pickedWortFormen!.successCounter) раз. И вот тогда это слово будет считаться как изученное!")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }else{
                        if(matchpoint){
                            HStack{
                                Text("Ошибок не было! В следующий раз добавим ещё одну форму этого слова для перевода!")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }else{
                            HStack{
                                Text("Ошибок не было! Но так как ранее в этом наборе были ошибки придётся подтвердить что ты точно знаешь этот набор форм слова позже правильным переводом ещё \(2-pickedWortFormen!.successCounter) раз(а). И тогда будет добавлена ещё одна форма этого слова для перевода.")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }
                }
            }else{
                if hasFaults{
                    HStack{
                        Text("Уже были ошибки. Придётся позже попробовать ещё раз. А пока продолжай переводить оставшиеся формы.")
                            .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                            .padding(.bottom, 10)
                        Spacer()
                    }
                }else{
                    if(gamepoint){
                        if(matchpoint){
                            HStack{
                                Text("Пока что ошибок не было! Ты в шаге от того, чтобы слово слиталось изученным. Просто переведи все оставшиеся формы правильно!")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }else{
                            HStack{
                                Text("Пока что ошибок не было! Продолжай в том же духе!")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }else{
                        if(matchpoint){
                            HStack{
                                Text("Пока что ошибок не было! Продолжай в том же духе и тогда в следующий раз добавим ещё одну форму этого слова для перевода!")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }else{
                            HStack{
                                Text("Пока что ошибок не было! Продолжай в том же духе!")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            NG_Button(title: "Всё понятно!", style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(true), action: {
                showProgressBarDetails = false
            }, widthFlood: true)
        }
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
                Image(systemName: "chevron.right.square.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                    .font(.system(size: 25))
                Image(systemName: "chevron.right.square.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.black, hasFaults ? .red : (!guessingResult.contains(-1) && !guessingResult.contains(0)) ? .green : .yellow)
                    .font(.system(size: 25))
                Image(systemName: "chevron.right.square.fill")
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
        .onTapGesture {
            showProgressBarDetails.toggle()
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
                            TimeStatistics.submitLearningTime(in: viewContext, at: Date.now.stripTime(), for: flipPassed[index], forThe: dasWort.relWortFormen?.relWortArt)
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
                            TimeStatistics.submitLearningTime(in: viewContext, at: Date.now.stripTime(), for: flipPassed[index], forThe: dasWort.relWortFormen?.relWortArt)
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
                    flipPassed[index] = 0.0
                    flipCompleted[index] = false
                    
                    if(flipTotal[index] >= 0){
                        
                        flipTimers[index] = PausableTimer(interval: 0.05) {
                            
                            if attemptCounter != thisCertainCounter || flippedSeite[index] {
                                flipTimers[index]?.invalidate()
                                flipTimers[index] = nil
                                return
                            }
                            
                            if(flipTicker[index] == 000){
                                withAnimation(.easeOut(duration: 0.3)) { flipScaleRatio[index] = 1.02 }
                                doWeNeedToAnnounce()
                            }
                            if(flipTicker[index] == 030){
                                withAnimation(.easeOut(duration: 0.7)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 100){
                                withAnimation(.easeOut(duration: 0.25)) { flipScaleRatio[index] = 1.04 }
                            }
                            if(flipTicker[index] == 125){
                                withAnimation(.easeOut(duration: 0.75)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 200){
                                withAnimation(.easeOut(duration: 0.2)) { flipScaleRatio[index] = 1.06 }
                            }
                            if(flipTicker[index] == 220){
                                withAnimation(.easeOut(duration: 0.8)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 300){
                                withAnimation(.easeOut(duration: 0.15)) { flipScaleRatio[index] = 1.08 }
                            }
                            if(flipTicker[index] == 315){
                                withAnimation(.easeOut(duration: 0.85)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 400){
                                withAnimation(.easeOut(duration: 0.1)) { flipScaleRatio[index] = 1.1 }
                            }
                            if(flipTicker[index] == 410){
                                withAnimation(.easeOut(duration: 0.9)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 500){
                                withAnimation(.easeOut(duration: 0.1)) { flipScaleRatio[index] = 1.1 }
                            }
                            if(flipTicker[index] == 510){
                                withAnimation(.easeOut(duration: 0.9)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 600){
                                withAnimation(.easeOut(duration: 0.1)) { flipScaleRatio[index] = 1.1 }
                            }
                            if(flipTicker[index] == 610){
                                withAnimation(.easeOut(duration: 0.9)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 700){
                                withAnimation(.easeOut(duration: 0.1)) { flipScaleRatio[index] = 1.1 }
                            }
                            if(flipTicker[index] == 710){
                                withAnimation(.easeOut(duration: 0.9)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 800){
                                withAnimation(.easeOut(duration: 0.1)) { flipScaleRatio[index] = 1.1 }
                            }
                            if(flipTicker[index] == 810){
                                withAnimation(.easeOut(duration: 0.9)) { flipScaleRatio[index] = 1 }
                            }
                            if(flipTicker[index] == 900){
                                withAnimation(.easeOut(duration: 0.1)) { flipScaleRatio[index] = 1.1 }
                            }
                            if(flipTicker[index] == 910){
                                withAnimation(.easeOut(duration: 0.9)) { flipScaleRatio[index] = 1 }
                            }
                            
                            flipPassed[index] += 0.05
                            flipTicker[index] += 5
                            
                            if flipPassed[index] >= flipTotal[index] {
                                flipCompleted[index] = true
                                flipTimers[index]?.invalidate()
                                flipTimers[index] = nil
                                if(attemptCounter == thisCertainCounter){
                                    if(!flippedSeite[index]){
                                        deutschesSeite[index] = true
                                        flippedSeite[index] = true
                                        missedGuess[index] = true
                                    }
                                }
                            }
                            
                        }
                        
                        flipTimers[index]?.start()
                    }
                }
                .onDisappear{
                    flipTimers[index]?.invalidate()
                    flipTimers[index] = nil
                    withAnimation(.easeOut(duration: 1.0)) { flipScaleRatio[index] = 1 }
                }
            }
        }
    }
    
    func doWeNeedToAnnounce(){
        if(pickedWortFormen != nil){
            let pickedWortArt = pickedWortFormen!.relWortArt
            if(TimeStatistics.isAboveYesterdayToAnnounce(in: viewContext, forThe: pickedWortArt)){
                showDailyWortArtAnnouncement =  true
            }else if(TimeStatistics.isAboveAverageToAnnounce(in: viewContext, forThe: pickedWortArt)){
                showAverageWortArtAnnouncement =  true
            }else if(TimeStatistics.isAboveYesterdayToAnnounce(in: viewContext, forThe: nil)){
                showDailyAnnouncement =  true
            }else if(TimeStatistics.isAboveAverageToAnnounce(in: viewContext, forThe: nil)){
                showAverageAnnouncement =  true
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
        flipTicker = Array(repeating: 0, count: wort.count)
        flipTotal = Array(repeating: Double(timeAttackMode), count: wort.count)
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
