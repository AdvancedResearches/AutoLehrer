import SwiftUI
import CoreData

struct WortRepeater: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    
    var wortArt: WortArt
    
    var prufungModus: Bool = false
    @State var runningWortArt: WortArt?
    @State var alleWortArten: [WortArt] = []
    @State var runningWortArtIndex: Int = 0
    @State var prufungWortFormen: [WortFormen] = []
    @State var prufungResult: [WortArt: Int] = [:]
    @State var prufungCompleted: Bool = false
    @State var prufungLoadCompleted: Bool = false
    @State var prufungButtonTrigger: Bool = false
    
    @State var pickedWortFormen: WortFormen?
    
    @State var hasFaults: Bool = false
    @State var guessingResult: [Int] = []
    @State var wort: [Wort] = []
    @State var fasttrackExtras: Int = 0
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
    @State var alleWorter: [Wort] = []
    
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
    
    @State var toBeatYesterday: String?
    @State var toBeatAverage: String?
    
    func recalcTimeToBeatReminder(){
        if(pickedWortFormen != nil){
            let statsForToday: TimeStatistics? = TimeStatistics.fetchLearningTime(in: viewContext, at: Date.now.stripTime(), forThe: pickedWortFormen!.relWortArt)
            let statsForYesterday: TimeStatistics? = TimeStatistics.fetchYesterdayLearningTime(in: viewContext, forThe: pickedWortFormen!.relWortArt)
            let statsForAverage: Double? = TimeStatistics.fetchWeeklyAverageLearningTime(in: viewContext, forThe: pickedWortFormen!.relWortArt)
            if(statsForToday != nil && statsForYesterday != nil && statsForAverage != nil){
                let remainderForYesterday = max(statsForYesterday!.learningTime - statsForToday!.learningTime, 0)
                let remainderForAverage = max(statsForAverage! - statsForToday!.learningTime, 0)
                if remainderForYesterday > 0 {
                    toBeatYesterday = Date.doubleSeconds_toMinutesAndSecondsString_RU(remainderForYesterday)
                }else{
                    toBeatYesterday = nil
                }
                if remainderForAverage > 0 {
                    if(remainderForAverage != remainderForYesterday){
                        toBeatAverage = Date.doubleSeconds_toMinutesAndSecondsString_RU(remainderForYesterday)
                    }else{
                        toBeatAverage = nil
                    }
                }else{
                    toBeatAverage = nil
                }
            }else{
                toBeatYesterday = nil
                toBeatAverage = nil
            }
        }else{
            toBeatYesterday = nil
            toBeatAverage = nil
        }
    }
    
    func prufungScore(_ forWA: WortArt? = nil) -> Double {
        if(forWA != nil){
            if let dasResult = prufungResult[forWA!] {
                return Double(100) * Double(dasResult) / Double(10)
            }else{
                return 0
            }
        }else{
            var ganzResult: Int = 0
            var countedResults: Int = 0
            for dasWA in alleWortArten{
                let dasResult = prufungScorePercent(dasWA)
                if(dasResult >= 0){
                    ganzResult += dasResult
                    countedResults += 1
                }
            }
            return Double(ganzResult) / Double(countedResults)
        }
        return 0
    }
    
    func prufungScorePercent(_ forWA: WortArt? = nil) -> Int {
        if(forWA != nil){
            if let dasResult = prufungResult[forWA!] {
                return Int(Double(100) * Double(dasResult) / Double(10))
            }else{
                return -1
            }
        }else{
            var ganzResult: Int = 0
            var countedResults: Int = 0
            for dasWA in alleWortArten{
                let dasResult = prufungScorePercent(dasWA)
                if(dasResult >= 0){
                    ganzResult += dasResult
                    countedResults += 1
                }
            }
            return countedResults > 0 ? Int(Double(ganzResult) / Double(countedResults)) : -1
        }
        return 0
    }
    
    func prufungResult(_ forWA: WortArt? = nil) -> String{
        let scorePercentage = prufungScorePercent(forWA)
        if(scorePercentage == 100){
            return "Отлично"
        }
        if(scorePercentage > 80){
            return "Хорошо"
        }
        if(scorePercentage > 60){
            return "Удовлетворительно"
        }
        if(scorePercentage > 40){
            return "Неудовлетворительно"
        }
        if(scorePercentage > 20){
            return "Плохо"
        }
        if(scorePercentage >= 0){
            return "Отвратительно"
        }
        return "Неизвестно"
    }
    
    func prufungResultNGTextTint(_ forWA: WortArt? = nil) -> NG_TextColor{
        let scorePercentage = prufungScorePercent(forWA)
        if(scorePercentage == 100){
            return .NG_TextColor_Green
        }
        if(scorePercentage > 80){
            return .NG_TextColor_Regular
        }
        if(scorePercentage > 60){
            return .NG_TextColor_Regular
        }
        if(scorePercentage > 40){
            return .NG_TextColor_Red
        }
        if(scorePercentage > 20){
            return .NG_TextColor_Red
        }
        if(scorePercentage >= 0){
            return .NG_TextColor_Red
        }
        return .NG_TextColor_Regular
    }
    
    var body: some View {
        VStack{
            if(!prufungModus){
                TimeStatisticsSection()
            }
            VStack {
                if(prufungModus){
                    dasPrufungProgressSektion()
                }else{
                    if(pickedWortFormen != nil){
                        dasProgressSektion()
                    }
                }
                if(prufungCompleted){
                    PrufungCompletedSection()
                }else{
                    if(prufungModus){
                        PrufungExamSection()
                    }else{
                        RegularTestingSection()
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .NG_Card(.NG_CardStyle_Regular, theme: theme)
            .onAppear{
                if(prufungModus){
                    pickTheWordFurPrufung()
                }else{
                    pickTheWord()
                }
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
            if(prufungModus){
                Settings.setLetztePrufung(Date.now, in: viewContext)
                print("Set letzte prufung fur jetzt")
            }
        }
    }
    
    private func TimeStatisticsSection() -> some View{
        Group{
            HStack{
                Text("В этой сессии: опробовано слов: \(exercisedWorte.count) / из них выучено: \(confirmedWorte.count)")
                    .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                    .padding(.horizontal, 5)
                Spacer()
            }
            if(toBeatYesterday != nil){
                HStack{
                    Text("Позаниматься ещё \(toBeatYesterday!) чтобы превысить вчерашний результат")
                        .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                        .padding(.horizontal, 5)
                    Spacer()
                }
            }
            if(toBeatAverage != nil){
                HStack{
                    Text("Позаниматься ещё \(toBeatAverage!) чтобы превысить средний результат за неделю")
                        .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                        .padding(.horizontal, 5)
                    Spacer()
                }
            }
        }
    }
    private func NextButton_Regular() -> some View{
        Group{
            let successFormen = guessingResult.filter{$0 == 1}.count
            let checkedFormen = guessingResult.count
            NG_Button(
                title: "Дальше (\(successFormen)/\(checkedFormen) было правильно)".localized(for: language),
                style: successFormen==checkedFormen ? .NG_ButtonStyle_Green : .NG_ButtonStyle_Red,
                isDisabled: .constant(false),
                isHighlighting: .constant(true),
                isPulsating: .constant(true),
                action: {
                    //print("Wort zahlung: INITIATED")
                    
                    //was ist das für?
                    //attemptCounter += 1
                    //Rechen success formen
                    let successCounter: Int = guessingResult.filter{$0 == 1}.count
                    let hasProgress: Bool = fasttrackExtras > 0
                    let allRight: Bool = successCounter == guessingResult.count
                    
                    //merken wort formen wie successful oder nicht successful
                    for theFormCounter in 0..<wort.count{
                        if(guessingResult[theFormCounter] == 1){
                            Statistics.set_success(wort[theFormCounter])
                            //successCounter += 1
                        }
                        if(guessingResult[theFormCounter] == -1){
                            Statistics.set_failure(wort[theFormCounter])
                        }
                    }
                    
                    
                    pickedWortFormen!.lastSucceeded = Int64(successCounter)
                    /*
                    //if(successCounter == wort.count){
                    if(!guessingResult.contains(0) && !guessingResult.contains(-1)){
                        //wenn all antworten sind rischig - kann sein nur wenn alle moglich wort formen war successfull
                        //print("Wort zahlung: ALLE WORT FORMEN WAR SUCCESSFUL")
                        if(WortFormen.set_success(pickedWortFormen!, attemptedFormen: wort)){
                            //print("Wort zahlung: --- counted wie completed")
                            confirmedWorte.insert(pickedWortFormen!)
                        }else{
                            //print("Wort zahlung: --- counted wie completed NICHT")
                        }
                    }else{
                        //print("Wort zahlung: das war fails")
                        
                        var failedWorter: [Wort] = []
                        for counter in 0..<guessingResult.count{
                            if(guessingResult[counter] == -1 ){
                                failedWorter.append(wort[counter])
                            }
                        }
                        
                        let failLevel = Int(failedWorter.map { $0.level ?? 0 }.min() ?? 0)
                        
                        WortFormen.set_failure(pickedWortFormen!, attemptedFormen: wort, failLevel: failLevel)
                        confirmedWorte.remove(pickedWortFormen!)
                    }
                    
                    WortFormen.set_attempted(pickedWortFormen!)
                    */
                    
                    if allRight{
                        WortFormen.submit_allRight(pickedWortFormen!)
                    }else if hasProgress{
                        WortFormen.submit_hasProgress(pickedWortFormen!)
                    }else{
                        WortFormen.submit_hasNoProgress(pickedWortFormen!)
                    }
                     
                    Statistics.wortFormenUrgency(pickedWortFormen!)
                    
                    
                    pickTheWord()
                    
                },
                widthFlood: true
            )
            .padding(.horizontal, 15)
            .padding(.vertical, 25)
            .transition(.scale)
        }
    }
    private func NextButton_Prufung_Skip() -> some View{
        Group{
            let successFormen = guessingResult.filter{$0 == 1}.count
            let checkedFormen = guessingResult.count
            NG_Button(
                title: "К следующему разделу".localized(for: language),
                style: .NG_ButtonStyle_Regular,
                isDisabled: .constant(false),
                isHighlighting: .constant(true),
                isPulsating: .constant(true),
                action: {
                    pickTheWordFurPrufung()
                },
                widthFlood: true
            )
            .padding(.horizontal, 15)
            .padding(.vertical, 25)
            .transition(.scale)
        }
    }
    private func NextButton_Prufung_Next() -> some View{
        Group{
            let successFormen = guessingResult.filter{$0 == 1}.count
            let checkedFormen = guessingResult.count
            NG_Button(
                title: "Дальше (\(successFormen)/\(checkedFormen) было правильно)".localized(for: language),
                style: successFormen==checkedFormen ? .NG_ButtonStyle_Green : .NG_ButtonStyle_Red,
                isDisabled: .constant(false),
                isHighlighting: .constant(true),
                isPulsating: .constant(true),
                action: {
                    prufungResult.updateValue(guessingResult.filter{$0 == 1}.count, forKey: runningWortArt!)
                    pickTheWordFurPrufung()
                },
                widthFlood: true
            )
            .padding(.horizontal, 15)
            .padding(.vertical, 25)
            .transition(.scale)
        }
    }
    private func NextButton_Prufung_Ende() -> some View{
        Group{
            NG_Button(
                title: "Экзамен закончен".localized(for: language),
                style: .NG_ButtonStyle_Regular,
                isDisabled: .constant(false),
                isHighlighting: .constant(false),
                isPulsating: .constant(true),
                action: {
                    dismiss()
                },
                widthFlood: true
            )
            .padding(.horizontal, 15)
            .padding(.vertical, 25)
            .transition(.scale)
        }
    }
    private func PrufungCompletedSection() -> some View{
        Group{
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: true){
                    HStack{
                        let precentageResult: Int = prufungScorePercent()
                        if(precentageResult >= 0){
                            Text("Общая оценка: \(prufungResult()) - \(prufungScorePercent())%")
                                .NG_textStyling(.NG_TextStyle_Text_Big, prufungResultNGTextTint(), theme: theme)
                        }else{
                            Text("Общая оценка: \(prufungResult())")
                                .NG_textStyling(.NG_TextStyle_Text_Big, prufungResultNGTextTint(), theme: theme)
                        }
                        
                        Spacer()
                    }
                    .NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .padding(.horizontal, 20)
                    ForEach(0..<alleWortArten.count){ index in
                        HStack{
                            let precentageResult: Int = prufungScorePercent(alleWortArten[index])
                            if(precentageResult >= 0){
                                Text("[\(alleWortArten[index].name_RU!)]: \(prufungResult(alleWortArten[index])) - \(prufungScorePercent(alleWortArten[index]))%")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, prufungResultNGTextTint(alleWortArten[index]), theme: theme)
                            }else{
                                Text("[\(alleWortArten[index].name_RU!)]: \(prufungResult(alleWortArten[index]))")
                                    .NG_textStyling(.NG_TextStyle_Text_Regular, prufungResultNGTextTint(alleWortArten[index]), theme: theme)
                            }
                            Spacer()
                        }
                        .padding(.leading, 20)
                    }
                    SizeAware(onChange: { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                proxy.scrollTo("bottom-anchor", anchor: .bottom)
                            }
                        }
                    }) {
                        NextButton_Prufung_Ende()
                    }
                }
            }
        }
    }
    private func PrufungExamSection() -> some View{
        Group{
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: true){
                    ForEach(Array(wort.enumerated()), id: \.element.objectID) { index, dasWort in
                        dasWortSektion(dasWort: dasWort, index: index)
                            .id(index)
                            .if(index > runningWort){ view in
                                view.opacity(0.2)
                            }
                    }
                    
                    if(wort.count > 0){
                        if(readyToMoveOn){
                            SizeAware(onChange: { _ in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
                                    withAnimation(.easeInOut(duration: 0.35)) {
                                        proxy.scrollTo("bottom-anchor", anchor: .bottom)
                                    }
                                }
                            }) {
                                NextButton_Prufung_Next()
                            }
                            
                        }
                    }else{
                        if(prufungLoadCompleted){
                            SizeAware(onChange: { _ in
                                print("PrufungExamSection.wortcount is 0. Scroll to bottom-anchor triggered")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
                                    withAnimation(.easeInOut(duration: 0.35)) {
                                        proxy.scrollTo("bottom-anchor", anchor: .bottom)
                                    }
                                }
                                
                            }) {
                                NextButton_Prufung_Skip()
                                    .id(prufungButtonTrigger)
                            }
                        }
                    }
                    
                    Color.clear.frame(height: 1).id("bottom-anchor")
                }
                .background(.clear)
                .animation(.easeInOut(duration: 0.35), value: prufungButtonTrigger)
                .onChange(of: prufungButtonTrigger){ newValue in
                    print("prufungButtonTrigger changed to \(newValue) and shall trigger animation")
                }
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
    }
    private func RegularTestingSection() -> some View{
        Group{
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
                                NextButton_Regular()
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
                Text("Всего форм у этого слова: \(WortFormen.alleFormenZahlung(pickedWortFormen!))")
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
            let gamepoint = pickedWortFormen!.formsToShow == WortFormen.alleFormenZahlung(pickedWortFormen!)
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
    private func iconNameByGuessingResultFurPrufungModus(_ index: Int) -> String{
        return guessingResult[index] == -1 ?  "multiply.square.fill" : guessingResult[index] == 0 ? "questionmark.square.fill" : "checkmark.square.fill"
    }
    private func iconColorByGuessingResultFurPrufungModus(_ index: Int) -> Color{
        return guessingResult[index] == -1 ?  Color.red : guessingResult[index] == 0 ? Color.yellow : Color.green
    }
    private func nummerIconName(_ nummer: Int) -> String{
        if(nummer == 0){
            return "0.square.fill"
        }
        if(nummer == 1){
            return "1.square.fill"
        }
        if(nummer == 2){
            return "2.square.fill"
        }
        if(nummer == 3){
            return "3.square.fill"
        }
        if(nummer == 4){
            return "4.square.fill"
        }
        if(nummer == 5){
            return "5.square.fill"
        }
        if(nummer == 6){
            return "6.square.fill"
        }
        if(nummer == 7){
            return "7.square.fill"
        }
        if(nummer == 8){
            return "8.square.fill"
        }
        if(nummer == 9){
            return "9.square.fill"
        }
        if(nummer == 10){
            return "10.square.fill"
        }
        return "square.slash.fill"
    }
    private func nummerIconColor(_ nummer: Int) -> Color{
        if(nummer == 0){
            return .red
        }
        if(nummer == 1){
            return .red
        }
        if(nummer == 2){
            return .red
        }
        if(nummer == 3){
            return .red
        }
        if(nummer == 4){
            return .red
        }
        if(nummer == 5){
            return .red
        }
        if(nummer == 6){
            return .yellow
        }
        if(nummer == 7){
            return .yellow
        }
        if(nummer == 8){
            return .yellow
        }
        if(nummer == 9){
            return .yellow
        }
        if(nummer == 10){
            return .green
        }
        return .gray
    }
    private func dasPrufungProgressSektion() -> some View {
        return VStack{
            if(prufungCompleted){
                HStack{
                    ForEach(0..<alleWortArten.count){ index in
                        let derPrufungResult: Int = prufungResult[alleWortArten[index]]!
                        let iconName = nummerIconName(derPrufungResult)
                        let iconColor = nummerIconColor(derPrufungResult)
                        Image(systemName: iconName)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black, iconColor)
                            .font(.system(size: 25))
                    }
                }
            }else{
                if(runningWortArt != nil){
                    if(wort.count > 0){
                        HStack{
                            Text("Проверяем раздел [\(runningWortArt!.name_RU!)]")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        }
                        HStack{
                            let iconName0 = iconNameByGuessingResultFurPrufungModus(0)
                            let iconColor0 = iconColorByGuessingResultFurPrufungModus(0)
                            let iconName1 = iconNameByGuessingResultFurPrufungModus(1)
                            let iconColor1 = iconColorByGuessingResultFurPrufungModus(1)
                            let iconName2 = iconNameByGuessingResultFurPrufungModus(2)
                            let iconColor2 = iconColorByGuessingResultFurPrufungModus(2)
                            let iconName3 = iconNameByGuessingResultFurPrufungModus(3)
                            let iconColor3 = iconColorByGuessingResultFurPrufungModus(3)
                            let iconName4 = iconNameByGuessingResultFurPrufungModus(4)
                            let iconColor4 = iconColorByGuessingResultFurPrufungModus(4)
                            let iconName5 = iconNameByGuessingResultFurPrufungModus(5)
                            let iconColor5 = iconColorByGuessingResultFurPrufungModus(5)
                            let iconName6 = iconNameByGuessingResultFurPrufungModus(6)
                            let iconColor6 = iconColorByGuessingResultFurPrufungModus(6)
                            let iconName7 = iconNameByGuessingResultFurPrufungModus(7)
                            let iconColor7 = iconColorByGuessingResultFurPrufungModus(7)
                            let iconName8 = iconNameByGuessingResultFurPrufungModus(8)
                            let iconColor8 = iconColorByGuessingResultFurPrufungModus(8)
                            let iconName9 = iconNameByGuessingResultFurPrufungModus(9)
                            let iconColor9 = iconColorByGuessingResultFurPrufungModus(9)
                            Image(systemName: iconName0)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor0)
                                .font(.system(size: 25))
                            Image(systemName: iconName1)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor1)
                                .font(.system(size: 25))
                            Image(systemName: iconName2)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor2)
                                .font(.system(size: 25))
                            Image(systemName: iconName3)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor3)
                                .font(.system(size: 25))
                            Image(systemName: iconName4)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor4)
                                .font(.system(size: 25))
                            Image(systemName: iconName5)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor5)
                                .font(.system(size: 25))
                            Image(systemName: iconName6)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor6)
                                .font(.system(size: 25))
                            Image(systemName: iconName7)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor7)
                                .font(.system(size: 25))
                            Image(systemName: iconName8)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor8)
                                .font(.system(size: 25))
                            Image(systemName: iconName9)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.black, iconColor9)
                                .font(.system(size: 25))
                        }
                    }else{
                        HStack{
                            Text("Пока ещё нечего проверять в  разделе [\(runningWortArt!.name_RU!)]")
                                .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        }
                    }
                }
            }
        }
        .onTapGesture {
            //showProgressBarDetails.toggle()
        }
        
    }
    private func forecastedProgressIconName() -> String {
        var forecastedFailState: Bool = false
        var forecastedRandomFailState: Bool = false
        var forecastedDepth: Int = 0
        
        let hasFails: Bool = guessingResult.contains(-1)
        let hasIncomplete: Bool = guessingResult.contains(0)
        
        if(hasFails){
            if(pickedWortFormen!.randomFail){
                forecastedDepth = 1
                forecastedFailState = true
                forecastedRandomFailState = false
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = Int(pickedWortFormen!.failCounter) + 1
                    forecastedFailState = true
                    forecastedRandomFailState = false
                }else{
                    if(pickedWortFormen!.successCounter >= WortFormen.treatedAsRandomFailCount){
                        forecastedDepth = Int(pickedWortFormen!.successCounter)
                        forecastedFailState = false
                        forecastedRandomFailState = true
                    }else{
                        forecastedDepth = 1
                        forecastedFailState = true
                        forecastedRandomFailState = false
                    }
                }
            }
        }else if(hasIncomplete){
            if(pickedWortFormen!.randomFail){
                forecastedDepth = Int(pickedWortFormen!.successCounter)
                forecastedFailState = false
                forecastedRandomFailState = false
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                }else{
                    forecastedDepth = Int(pickedWortFormen!.successCounter) + 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                }
            }
        }else{
            if(pickedWortFormen!.randomFail){
                forecastedDepth = Int(pickedWortFormen!.successCounter)
                forecastedFailState = false
                forecastedRandomFailState = false
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                }else{
                    forecastedDepth = Int(pickedWortFormen!.successCounter) + 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                }
            }
        }
        
        if(forecastedRandomFailState){
            if(forecastedRandomFailState){
                return "person.fill.questionmark"
            }else{
                if(forecastedDepth <= 1){
                    return "1.square.fill"
                }
                if(forecastedDepth == 2){
                    return "2.square.fill"
                }
                if(forecastedDepth == 3){
                    return "3.square.fill"
                }
                if(forecastedDepth == 4){
                    return "4.square.fill"
                }
                if(forecastedDepth == 5){
                    return "5.square.fill"
                }
                return "hand.thumbsdown.fill"
            }
        }else{
            if(forecastedDepth <= 1){
                return "1.square.fill"
            }
            if(forecastedDepth == 2){
                return "2.square.fill"
            }
            if(forecastedDepth == 3){
                return "3.square.fill"
            }
            if(forecastedDepth == 4){
                return "4.square.fill"
            }
            if(forecastedDepth == 5){
                return "5.square.fill"
            }
            return "star.square.fill"
        }
        
        return "questionmark.app.fill"
    }
    private func forecastedProgressIconStyle() -> NG_IconStyle {
        var forecastedFailState: Bool = false
        var forecastedRandomFailState: Bool = false
        var forecastedDepth: Int = 0
        
        let hasFails: Bool = guessingResult.contains(-1)
        let hasIncomplete: Bool = guessingResult.contains(0)
        
        if(hasFails){
            if(pickedWortFormen!.randomFail){
                forecastedDepth = 1
                forecastedFailState = true
                forecastedRandomFailState = false
                return .NG_IconStyle_Red
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = Int(pickedWortFormen!.failCounter) + 1
                    forecastedFailState = true
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Red
                }else{
                    if(pickedWortFormen!.successCounter >= WortFormen.treatedAsRandomFailCount){
                        forecastedDepth = Int(pickedWortFormen!.successCounter)
                        forecastedFailState = false
                        forecastedRandomFailState = true
                        return .NG_IconStyle_Regular
                    }else{
                        forecastedDepth = 1
                        forecastedFailState = true
                        forecastedRandomFailState = false
                        return .NG_IconStyle_Red
                    }
                }
            }
        }else if(hasIncomplete){
            if(pickedWortFormen!.randomFail){
                forecastedDepth = Int(pickedWortFormen!.successCounter)
                forecastedFailState = false
                forecastedRandomFailState = false
                return .NG_IconStyle_Regular
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Regular
                }else{
                    forecastedDepth = Int(pickedWortFormen!.successCounter) + 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Regular
                }
            }
        }else{
            if(pickedWortFormen!.randomFail){
                forecastedDepth = Int(pickedWortFormen!.successCounter)
                forecastedFailState = false
                forecastedRandomFailState = false
                return .NG_IconStyle_Green
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Green
                }else{
                    forecastedDepth = Int(pickedWortFormen!.successCounter) + 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Green
                }
            }
        }
        
        return .NG_IconStyle_Regular
    }
    private func forecastedProgressIconGlareStyle() -> NG_IconStyle? {
        var forecastedFailState: Bool = false
        var forecastedRandomFailState: Bool = false
        var forecastedDepth: Int = 0
        
        let hasFails: Bool = guessingResult.contains(-1)
        let hasIncomplete: Bool = guessingResult.contains(0)
        
        if(hasFails){
            if(pickedWortFormen!.randomFail){
                forecastedDepth = 1
                forecastedFailState = true
                forecastedRandomFailState = false
                return .NG_IconStyle_Red
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = Int(pickedWortFormen!.failCounter) + 1
                    forecastedFailState = true
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Red
                }else{
                    if(pickedWortFormen!.successCounter >= WortFormen.treatedAsRandomFailCount){
                        forecastedDepth = Int(pickedWortFormen!.successCounter)
                        forecastedFailState = false
                        forecastedRandomFailState = true
                        return .NG_IconStyle_Regular
                    }else{
                        forecastedDepth = 1
                        forecastedFailState = true
                        forecastedRandomFailState = false
                        return .NG_IconStyle_Red
                    }
                }
            }
        }else if(hasIncomplete){
            if(pickedWortFormen!.randomFail){
                forecastedDepth = Int(pickedWortFormen!.successCounter)
                forecastedFailState = false
                forecastedRandomFailState = false
                return .NG_IconStyle_Yellow
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Yellow
                }else{
                    forecastedDepth = Int(pickedWortFormen!.successCounter) + 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Yellow
                }
            }
        }else{
            if(pickedWortFormen!.randomFail){
                forecastedDepth = Int(pickedWortFormen!.successCounter)
                forecastedFailState = false
                forecastedRandomFailState = false
                return .NG_IconStyle_Green
            }else{
                if(pickedWortFormen!.failed){
                    forecastedDepth = 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Green
                }else{
                    forecastedDepth = Int(pickedWortFormen!.successCounter) + 1
                    forecastedFailState = false
                    forecastedRandomFailState = false
                    return .NG_IconStyle_Green
                }
            }
        }
        
        return .NG_IconStyle_Regular
    }
    private func progressIconName() -> String {
        if(pickedWortFormen!.failed){
            if(pickedWortFormen!.randomFail){
                return "person.fill.questionmark"
            }else{
                if(pickedWortFormen!.failCounter <= 1){
                    return "1.square.fill"
                }
                if(pickedWortFormen!.failCounter == 2){
                    return "2.square.fill"
                }
                if(pickedWortFormen!.failCounter == 3){
                    return "3.square.fill"
                }
                if(pickedWortFormen!.failCounter == 4){
                    return "4.square.fill"
                }
                if(pickedWortFormen!.failCounter == 5){
                    return "5.square.fill"
                }
                return "hand.thumbsdown.fill"
            }
        }else{
            if(pickedWortFormen!.successCounter <= 1){
                return "1.square.fill"
            }
            if(pickedWortFormen!.successCounter == 2){
                return "2.square.fill"
            }
            if(pickedWortFormen!.successCounter == 3){
                return "3.square.fill"
            }
            if(pickedWortFormen!.successCounter == 4){
                return "4.square.fill"
            }
            if(pickedWortFormen!.successCounter == 5){
                return "5.square.fill"
            }
            return "star.square.fill"
        }
    }
    private func progressIconStyle() -> NG_IconStyle {
        if(pickedWortFormen!.failed){
            return .NG_IconStyle_Red
        }else{
            return .NG_IconStyle_Green
        }
    }
    private func dasProgressSektion() -> some View {
        return HStack{
            DualColorBar(
                greenvalue: WortFormen.succeededFormenRatio(pickedWortFormen!),
                yellowvalue: WortFormen.attemptingFormenRatio(pickedWortFormen!, fasttrackExtras: fasttrackExtras),
                height: 25,
                pulseyellowtogreen: $potentiallyAddWortForme,
                highlightColor: .constant(guessingResult.contains(-1) ? .red : guessingResult.contains(0) ? .yellow : .green)
            )
            .onAppear{
                potentiallyAddWortForme = (!pickedWortFormen!.failed) || (pickedWortFormen!.failed && pickedWortFormen!.successCounter >= 2)
                //print("Initialize potential word form add - pulse to \(potentiallyAddWortForme)")
            }
            .onChange(of: hasFaults){ _, newValue in
                if(newValue){
                    potentiallyAddWortForme = false
                    //print("Discard potential word form add - pulse false")
                }else{
                    potentiallyAddWortForme = (!pickedWortFormen!.failed) || (pickedWortFormen!.failed && pickedWortFormen!.successCounter >= 2)
                    //print("Reset potential word form add - pulse to \(potentiallyAddWortForme)")
                }
            }
            Image(systemName: progressIconName())
                .resizable()
                .frame(width: 25, height: 25)
                .NG_iconStyling(progressIconStyle(), isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 15, height: 15)
                .NG_iconStyling(.NG_IconStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
            Image(systemName: forecastedProgressIconName())
                .resizable()
                .frame(width: 25, height: 25)
                .NG_iconStyling(forecastedProgressIconStyle(), isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
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
                                    if readyToMoveOn {
                                        prufungButtonTrigger.toggle()
                                    }
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
                                    if readyToMoveOn {
                                        prufungButtonTrigger.toggle()
                                    }
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
                                if(!prufungModus){
                                    nechsterFormAppennding()
                                }
                                readyToMoveOn = guessingResult.allSatisfy { $0 != 0}
                                if readyToMoveOn {
                                    prufungButtonTrigger.toggle()
                                }
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
                            let dieWortArt: WortArt? = prufungModus ? runningWortArt : dasWort.relWortFormen?.relWortArt
                            TimeStatistics.submitLearningTime(in: viewContext, at: Date.now.stripTime(), for: flipPassed[index], forThe: dieWortArt)
                            recalcTimeToBeatReminder()
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
                                if readyToMoveOn {
                                    prufungButtonTrigger.toggle()
                                }
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
                            let dieWortArt: WortArt? = prufungModus ? runningWortArt : dasWort.relWortFormen?.relWortArt
                            TimeStatistics.submitLearningTime(in: viewContext, at: Date.now.stripTime(), for: flipPassed[index], forThe: dieWortArt)
                            recalcTimeToBeatReminder()
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
                    //print("Initiate flipping for index \(index)")
                    
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
    private func sollMehrFormJetztZuappenden() -> Bool {
        if guessingResult.contains(0){
            return false
        }
        if guessingResult.contains(-1){
            return false
        }
        return true
    }
    private func nechsterFormAppennding(){
        //print("nechsterFormAppennding invoked")
        if(sollMehrFormJetztZuappenden()){
            //print("sollMehrFormJetztZuappenden pass")
            //print("worter bevor: \(wort.count) aus \(alleWorter.count)")
            if(alleWorter.count>wort.count){
                //for theCounter in 0..<topWorte.count{
                //    wort.append(topWorte[theCounter])
                //    beispiel.append(Wort.get_beispiel(topWorte[theCounter]))
                //    wortForm.append(WortArtFormen.fromWort(topWorte[theCounter]))
                //}
                let wortIndexToAppend: Int = wort.count
                wort.append(alleWorter[wortIndexToAppend])
                beispiel.append(Wort.get_beispiel(alleWorter[wortIndexToAppend]))
                wortForm.append(WortArtFormen.fromWort(alleWorter[wortIndexToAppend]))
                
                //deutschesSeite = Array(repeating: false, count: wort.count)
                deutschesSeite.append(false)
                //flippedSeite = Array(repeating: false, count: wort.count)
                flippedSeite.append(false)
                //missedGuess = Array(repeating: false, count: wort.count)
                missedGuess.append(false)
                //flipScaleRatio = Array(repeating: 1, count: wort.count)
                flipScaleRatio.append(1)
                //flipTimers = Array(repeating: nil, count: wort.count)
                flipTimers.append(nil)
                //flipPassed = Array(repeating: 0, count: wort.count)
                flipPassed.append(0)
                //flipTicker = Array(repeating: 0, count: wort.count)
                flipTicker.append(0)
                //flipTotal = Array(repeating: Double(timeAttackMode), count: wort.count)
                flipTotal.append(Double(timeAttackMode))
                //flipCompleted = Array(repeating: false, count: wort.count)
                flipCompleted.append(false)
                //flipShakingRatio = Array(repeating: 1, count: wort.count)
                flipShakingRatio.append(1)
                //guessingResult = Array(repeating: 0, count: wort.count)
                guessingResult.append(0)
                readyToMoveOn = false
                //runningWort += 1
                hasFaults = false
                //pickedWortFormen = pickedSache
                //potentiallyAddWortForme = (!pickedWortFormen!.failed) || (pickedWortFormen!.failed && pickedWortFormen!.successCounter >= 2)
                fasttrackExtras += 1
            }
            //print("worter nachdem: \(wort.count) aus \(alleWorter.count)")
        } else {
            //print("sollMehrFormJetztZuappenden fail")
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
        let pickedSache = Statistics.pickWortFormen_2(wortArt)
        //print("WortRepeater.pickTheWord(): picked sache: \(pickedSache.relWortArt!.name_DE!)-\(pickedSache.wortFrequencyOrder)")
                
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
        fasttrackExtras = 0
        
        exercisedWorte.insert(pickedSache)
        
        wort = []
        beispiel = []
        
        //print("WortRepeater.pickTheWord(): pickedSache.formsToShow: \(pickedSache.formsToShow)")
        
        var appendedCount = 0
        
        var theCounter = 0
        
        var topWorte: [Wort] = WortFormen.retrieve_allAllowedFormen(pickedSache)
        
        alleWorter = WortFormen.retrieve_alleFormen(pickedSache)
        
        for theCounter in 0..<topWorte.count{
            wort.append(topWorte[theCounter])
            beispiel.append(Wort.get_beispiel(topWorte[theCounter]))
            wortForm.append(WortArtFormen.fromWort(topWorte[theCounter]))
        }
        
        //print("WortRepeater.pickTheWord(): wort.count: \(wort.count)")
        
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
        
        recalcTimeToBeatReminder()
    }
    func pickTheWordFurPrufung() {
        prufungLoadCompleted = false
        readyToMoveOn = false
        runningWort = 0
        
        if(alleWortArten.isEmpty){
            alleWortArten = try! viewContext.fetch(WortArt.fetchRequest()).sorted{$0.order < $1.order}
            print("pickTheWordFurPrufung: loaded alleWortArten")
        }
        
        if prufungResult.isEmpty {
            for dieWortArt in alleWortArten {
                prufungResult.updateValue(-1, forKey: dieWortArt)
            }
            print("pickTheWordFurPrufung: setup prufungResult")
        }
        
        if(runningWortArtIndex >= alleWortArten.count){
            prufungCompleted = true
            for theWortArt in alleWortArten {
                TimeStatistics.submitExamResults(in: viewContext, at: Date.now.stripTime(), for: prufungScore(theWortArt), forThe: theWortArt)
            }
            TimeStatistics.submitExamResults(in: viewContext, at: Date.now.stripTime(), for: prufungScore(nil), forThe: nil)
            print("pickTheWordFurPrufung: end of exam detected")
            prufungLoadCompleted = true
            return
        }else{
            prufungCompleted = false
            print("pickTheWordFurPrufung: continuation of exam detected")
        }
        runningWortArt = alleWortArten[runningWortArtIndex]
        
        var wortenZuWalhlenAus: [Wort] = WortArt.fetch_alleConfirmedWorten(runningWortArt!)
        
        var gewahltWorter: [Wort] = Array(wortenZuWalhlenAus.shuffled().prefix(10))
        
        pickedWortFormen = nil
        wort = []
        beispiel = []
        deutschesSeite = []
        flippedSeite = []
        missedGuess = []
        flipScaleRatio = []
        guessingResult = []
        wortForm = []
        prufungWortFormen = []
        
        print("pickTheWordFurPrufung: fetched worten count is \(gewahltWorter.count) fur \(runningWortArt?.name_RU)")
        
        if(gewahltWorter.count < 10){
            print("pickTheWordFurPrufung: detected demand to skip the wort art")
            runningWortArtIndex += 1
            prufungLoadCompleted = true
            prufungButtonTrigger.toggle()
            return
        }
        
        print("pickTheWordFurPrufung: proceed mit den wortarten")
        
        for theCounter in 0..<gewahltWorter.count{
            wort.append(gewahltWorter[theCounter])
            beispiel.append(Wort.get_beispiel(gewahltWorter[theCounter]))
            wortForm.append(WortArtFormen.fromWort(gewahltWorter[theCounter]))
            prufungWortFormen.append(gewahltWorter[theCounter].relWortFormen!)
        }
        
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
        pickedWortFormen = prufungWortFormen[0]
        potentiallyAddWortForme = (!pickedWortFormen!.failed) || (pickedWortFormen!.failed && pickedWortFormen!.successCounter >= 2)
        prufungResult.updateValue(0, forKey: runningWortArt!)
        runningWortArtIndex += 1
        prufungLoadCompleted = true
    }
}
