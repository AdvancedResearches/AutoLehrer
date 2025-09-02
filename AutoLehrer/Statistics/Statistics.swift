//
//  ArchivalMenu.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 13.02.24.
//

import Foundation
import SwiftUI
import CoreData
import Charts

struct StatsItem: Identifiable{
    var id: Int
    var timeStamp: Date
    var learnTime: Double?
    var totalFormen: Int64?
    var confirmedFormen: Int64?
    var examMin: Double?
    var examMax: Double?
    var examAverage: Double?
}

struct PieChartItem: Identifiable {
    var id = UUID()
    var wortArtName: String
    var value: Double
}

struct TableItem: Identifiable {
    var id = UUID()
    var wortArtName: String
    var today: Double
    var yesterday: Double
    var average: Double
}

struct StatisticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeManager
    
    @AppStorage("appLanguage") var language: String = "ru"
    
    @State var currentTheme: Theme_Style = .regular
    
    @State var statArray: [StatsItem] = []
    @State var learningPieChartData: [PieChartItem] = []
    @State var learningTableData: [TableItem] = []
    @State var wortArten: [WortArt] = []
    @State var selectedArt: Int = -1
    @State var baseId: Int = 0
    
    @State var scaler_1: CGFloat = 0.1
    @State var scaler_2: CGFloat = 0.1
    @State var scaler_3: CGFloat = 0.1
    
    @State var mode_1: Int = 0
    @State var mode_2: Int = 0
    @State var mode_3: Int = 0
    
    @State var initiated: Bool = false
    
    var body: some View{
        NavigationStack {
            let third = UIScreen.main.bounds.height / 3.0
            let threefourth = UIScreen.main.bounds.height * 3.0 / 4.0
            ScrollView(.vertical){
                VStack {
                    VStack{
                        HStack{
                            Text("Время изучения")
                                .NG_textStyling(.NG_TextStyle_SectionHeader, theme: theme)
                                .padding(.leading, 10)
                            Picker("Типы", selection: $selectedArt) {
                                Text("В целом").tag(-1)
                                ForEach(Array(wortArten.enumerated()), id: \.element) { index, theArt in
                                    Text(theArt.name_RU ?? "")
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                            .onChange(of: selectedArt){ newValue in
                                if(newValue != -1){
                                    mode_1 = 0
                                    mode_2 = 0
                                    mode_3 = 0
                                }
                            }
                            if(selectedArt == -1){
                                Spacer()
                                    .transition(.blurReplace)
                                if(mode_1 == 0){
                                    Image(systemName: "chart.xyaxis.line")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_1 = 1
                                        }
                                }
                                if(mode_1 == 1){
                                    Image(systemName: "chart.pie")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_1 = 2
                                        }
                                }
                                if(mode_1 == 2){
                                    Image(systemName: "rectangle.split.3x3")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_1 = 0
                                        }
                                }
                            }else{
                                Spacer()
                                    .transition(.blurReplace)
                            }
                        }
                        .animation(.easeInOut(duration: 0.5), value: selectedArt)
                        let chartFromDate: Date = (statArray.first?.timeStamp ?? Date()).offset_inDays(-2)
                        let chartToDate: Date = (statArray.last?.timeStamp ?? Date()).offset_inDays(2)
                        if(mode_1==0){
                            Chart {
                                ForEach(statArray) { theStat in
                                    if let learn = theStat.learnTime {
                                        let minutes = learn / 60
                                        LineMark(
                                            x: .value("Date", theStat.timeStamp),
                                            y: .value("learnTime", minutes),
                                            series: .value("Metric", "learnTime")
                                        )
                                        .foregroundStyle(.green)
                                        .interpolationMethod(.linear)
                                        .lineStyle(StrokeStyle(lineWidth: 2))
                                        
                                        PointMark(
                                            x: .value("Date", theStat.timeStamp),
                                            y: .value("Learn", minutes)
                                        )
                                        .symbol {
                                            Rectangle()
                                                .foregroundColor(.green)
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                                }
                            }
                            .chartXScale(domain: chartFromDate ... chartToDate)
                            .chartXAxis {
                                AxisMarks(preset: .aligned) { mark in
                                    AxisGridLine()
                                        .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray.opacity(0.5)*/) // цвет линий сетки по X
                                    AxisTick()
                                        .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray*/) // цвет "чеков"
                                    AxisValueLabel()
                                        .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.white*/) // цвет подписей
                                }
                            }
                            .chartYAxis {
                                AxisMarks(preset: .extended) { mark in
                                    AxisGridLine()
                                        .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray.opacity(0.5)*/) // линии сетки по Y
                                    AxisTick()
                                        .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray*/)
                                    AxisValueLabel()
                                        .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.white*/)
                                }
                            }
                            .padding()
                            .frame(height: scaler_1)
                            .gesture(
                                MagnificationGesture()
                                    .onEnded { value in
                                        withAnimation(.easeInOut) {
                                            if value > 1 {
                                                // pinch-out → увеличиваем
                                                scaler_1 = threefourth
                                                print("chart 1 pinch-out")
                                            } else {
                                                // pinch-in → уменьшаем
                                                scaler_1 = third
                                                print("chart 1 pinch-in")
                                            }
                                        }
                                    }
                            )
                            .id(baseId+100000)
                            .transition(.blurReplace)
                        }
                        if(mode_1==1){
                            let scale: [String: Color] = Dictionary(uniqueKeysWithValues:
                                learningPieChartData.enumerated().map { i, slice in
                                    (slice.wortArtName, Color(hue: Double(i) / Double(learningPieChartData.count),
                                                              saturation: 0.7,
                                                              brightness: 0.9))
                                }
                            )
                            VStack(alignment: .leading, spacing: 1){
                                Chart(learningPieChartData) { slice in
                                    SectorMark(
                                        angle: .value("Значение", slice.value),
                                        innerRadius: .ratio(0.2),   // 0 → pie, >0 → donut
                                        outerRadius: .ratio(1.0)
                                    )
                                    //.foregroundStyle(by: .value("Категория", slice.wortArtName))
                                    .foregroundStyle(scale[slice.wortArtName] ?? .gray)
                                }
                                VStack(alignment: .leading, spacing: 1) {
                                    ForEach(learningPieChartData) { slice in
                                        HStack(spacing: 8) {
                                            Circle()
                                                .fill(scale[slice.wortArtName] ?? .gray)
                                                .frame(width: 12, height: 12)
                                            Text(slice.wortArtName)
                                                .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme) // любые модификаторы тут
                                        }
                                    }
                                }
                            }
                            .padding()
                            .frame(height: scaler_1)
                            .gesture(
                                MagnificationGesture()
                                    .onEnded { value in
                                        withAnimation(.easeInOut) {
                                            if value > 1 {
                                                // pinch-out → увеличиваем
                                                scaler_1 = threefourth
                                                print("chart 1 pinch-out")
                                            } else {
                                                // pinch-in → уменьшаем
                                                scaler_1 = third
                                                print("chart 1 pinch-in")
                                            }
                                        }
                                    }
                            )
                            .id(baseId+110000)
                            .transition(.blurReplace)
                        }
                        if(mode_1==2){
                            let scale: [String: Color] = Dictionary(uniqueKeysWithValues:
                                learningPieChartData.enumerated().map { i, slice in
                                    (slice.wortArtName, Color(hue: Double(i) / Double(learningPieChartData.count),
                                                              saturation: 0.7,
                                                              brightness: 0.9))
                                }
                            )
                            VStack{
                                Grid{
                                    ForEach(learningTableData) { learningItem in
                                        GridRow{
                                            HStack{
                                                Text(learningItem.wortArtName)
                                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                Spacer()
                                            }
                                            .gridCellColumns(3)
                                        }
                                        HStack{
                                            GridRow{
                                                Text("Today")
                                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                Text("Yesterday")
                                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                                Text("Average")
                                                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                                            }
                                            Spacer()
                                        }
                                        .padding(.leading, 10)
                                    }
                                }
                            }
                            .padding()
                            .gesture(
                                MagnificationGesture()
                                    .onEnded { value in
                                        withAnimation(.easeInOut) {
                                            if value > 1 {
                                                // pinch-out → увеличиваем
                                                scaler_1 = threefourth
                                                print("chart 1 pinch-out")
                                            } else {
                                                // pinch-in → уменьшаем
                                                scaler_1 = third
                                                print("chart 1 pinch-in")
                                            }
                                        }
                                    }
                            )
                            .id(baseId+110000)
                            .transition(.blurReplace)
                        }
                    }
                    .NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .id(baseId+150000)
                    .transition(.blurReplace)
                    .animation(.easeInOut(duration: 0.5), value: mode_1)
                    .padding(.horizontal)
                    
                    
                    VStack{
                        HStack{
                            Text("Степень изучения")
                                .NG_textStyling(.NG_TextStyle_SectionHeader, theme: theme)
                                .padding(.leading, 10)
                            Picker("Типы", selection: $selectedArt) {
                                Text("В целом").tag(-1)
                                ForEach(Array(wortArten.enumerated()), id: \.element) { index, theArt in
                                    Text(theArt.name_RU ?? "")
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                            if(selectedArt == -1){
                                Spacer()
                                    .transition(.blurReplace)
                                if(mode_2 == 0){
                                    Image(systemName: "chart.xyaxis.line")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_2 = 1
                                        }
                                }
                                if(mode_2 == 1){
                                    Image(systemName: "chart.pie")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_2 = 2
                                        }
                                }
                                if(mode_2 == 2){
                                    Image(systemName: "rectangle.split.3x3")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_2 = 0
                                        }
                                }
                            }else{
                                Spacer()
                                    .transition(.blurReplace)
                            }
                        }
                        .animation(.easeInOut(duration: 0.5), value: selectedArt)
                        .animation(.easeInOut(duration: 0.5), value: mode_2)
                        let chartFromDate: Date = (statArray.first?.timeStamp ?? Date()).offset_inDays(-2)
                        let chartToDate: Date = (statArray.last?.timeStamp ?? Date()).offset_inDays(2)
                        Chart {
                            ForEach(statArray) { theStat in
                                if let completed = theStat.confirmedFormen {
                                    if let total = theStat.totalFormen {
                                        let completionRate: Int = Int(100 * Double( Double(completed) / Double(total)))
                                        LineMark(
                                            x: .value("Date", theStat.timeStamp),
                                            y: .value("completionRate", completionRate),
                                            series: .value("Metric", "learnTime")
                                        )
                                        .foregroundStyle(.green)
                                        .interpolationMethod(.linear)
                                        .lineStyle(StrokeStyle(lineWidth: 2))
                                        
                                        PointMark(
                                            x: .value("Date", theStat.timeStamp),
                                            y: .value("completionRate", completionRate)
                                        )
                                        .symbol {
                                            Rectangle()
                                                .foregroundColor(.green)
                                                .frame(width: 10, height: 10)
                                        }
                                    }
                                }
                            }
                        }
                        .chartXScale(domain: chartFromDate ... chartToDate)
                        .chartYScale(domain: 0 ... 100)
                        .chartXAxis {
                            AxisMarks(preset: .aligned) { mark in
                                AxisGridLine()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray.opacity(0.5)*/) // цвет линий сетки по X
                                AxisTick()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray*/) // цвет "чеков"
                                AxisValueLabel()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.white*/) // цвет подписей
                            }
                        }
                        .chartYAxis {
                            AxisMarks(preset: .extended) { mark in
                                AxisGridLine()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray.opacity(0.5)*/) // линии сетки по Y
                                AxisTick()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray*/)
                                AxisValueLabel()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.white*/)
                            }
                        }
                        .padding()
                        //.frame(maxHeight: UIScreen.main.bounds.height / 2)
                        .frame(height: scaler_2)
                        .gesture(
                            MagnificationGesture()
                                .onEnded { value in
                                    withAnimation(.easeInOut) {
                                        if value > 1 {
                                            // pinch-out → увеличиваем
                                            scaler_2 = threefourth
                                            print("chart 1 pinch-out")
                                        } else {
                                            // pinch-in → уменьшаем
                                            scaler_2 = third
                                            print("chart 1 pinch-in")
                                        }
                                    }
                                }
                        )
                        .id(baseId+200000)
                        .transition(.blurReplace)
                    }
                    .NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .padding(.horizontal)
                    
                    VStack{
                        HStack{
                            Text("Экзамен")
                                .NG_textStyling(.NG_TextStyle_SectionHeader, theme: theme)
                                .padding(.leading, 10)
                            Picker("Типы", selection: $selectedArt) {
                                Text("В целом").tag(-1)
                                ForEach(Array(wortArten.enumerated()), id: \.element) { index, theArt in
                                    Text(theArt.name_RU ?? "")
                                        .tag(index)
                                }
                            }
                            .pickerStyle(.menu)
                            if(selectedArt == -1){
                                Spacer()
                                    .transition(.blurReplace)
                                if(mode_3 == 0){
                                    Image(systemName: "chart.xyaxis.line")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_3 = 1
                                        }
                                }
                                if(mode_3 == 1){
                                    Image(systemName: "chart.pie")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_3 = 2
                                        }
                                }
                                if(mode_3 == 2){
                                    Image(systemName: "rectangle.split.3x3")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                                        .transition(.blurReplace)
                                        .onTapGesture{
                                            mode_3 = 0
                                        }
                                }
                            }else{
                                Spacer()
                                    .transition(.blurReplace)
                            }
                        }
                        .animation(.easeInOut(duration: 0.5), value: selectedArt)
                        .animation(.easeInOut(duration: 0.5), value: mode_3)
                        let chartFromDate: Date = (statArray.first?.timeStamp ?? Date()).offset_inDays(-2)
                        let chartToDate: Date = (statArray.last?.timeStamp ?? Date()).offset_inDays(2)
                        Chart {
                            ForEach(statArray) { theStat in
                                if let min = theStat.examMin {
                                    LineMark(
                                        x: .value("Date", theStat.timeStamp),
                                        y: .value("examMinRate", min),
                                        series: .value("Percentage", "examMinRate")
                                    )
                                    .foregroundStyle(.red)
                                    .interpolationMethod(.linear)
                                    .lineStyle(StrokeStyle(lineWidth: 2))
                                    /*
                                    PointMark(
                                        x: .value("Date", theStat.timeStamp),
                                        y: .value("examMinRate", min)
                                    )
                                    .symbol {
                                        Rectangle()
                                            .foregroundColor(.red)
                                            .frame(width: 10, height: 10)
                                    }*/
                                }
                                if let max = theStat.examMax {
                                    LineMark(
                                        x: .value("Date", theStat.timeStamp),
                                        y: .value("examMaxRate", max),
                                        series: .value("Percentage", "examMaxRate")
                                    )
                                    .foregroundStyle(.green)
                                    .interpolationMethod(.linear)
                                    .lineStyle(StrokeStyle(lineWidth: 5))
                                    /*
                                    PointMark(
                                        x: .value("Date", theStat.timeStamp),
                                        y: .value("examMaxRate", max)
                                    )
                                    .symbol {
                                        Rectangle()
                                            .foregroundColor(.green)
                                            .frame(width: 10, height: 10)
                                    }*/
                                }
                                if let average = theStat.examAverage {
                                    LineMark(
                                        x: .value("Date", theStat.timeStamp),
                                        y: .value("examAverageRate", average),
                                        series: .value("Percentage", "examAverageRate")
                                    )
                                    .foregroundStyle(.blue)
                                    .interpolationMethod(.linear)
                                    .lineStyle(StrokeStyle(lineWidth: 5))
                                    
                                    PointMark(
                                        x: .value("Date", theStat.timeStamp),
                                        y: .value("examAverageRate", average)
                                    )
                                    .symbol {
                                        Rectangle()
                                            .foregroundColor(.blue)
                                            .frame(width: 10, height: 10)
                                    }
                                }
                            }
                        }
                        .chartXScale(domain: chartFromDate ... chartToDate)
                        .chartYScale(domain: 0 ... 100)
                        .chartXAxis {
                            AxisMarks(preset: .aligned) { mark in
                                AxisGridLine()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray.opacity(0.5)*/) // цвет линий сетки по X
                                AxisTick()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray*/) // цвет "чеков"
                                AxisValueLabel()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.white*/) // цвет подписей
                            }
                        }
                        .chartYAxis {
                            AxisMarks(preset: .extended) { mark in
                                AxisGridLine()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray.opacity(0.5)*/) // линии сетки по Y
                                AxisTick()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.gray*/)
                                AxisValueLabel()
                                    .foregroundStyle(theme.currentTheme.NG_Color_Text_Regular_Text/*Color.white*/)
                            }
                        }
                        .padding()
                        .frame(height: scaler_3)
                        .gesture(
                            MagnificationGesture()
                                .onEnded { value in
                                    withAnimation(.easeInOut) {
                                        if value > 1 {
                                            // pinch-out → увеличиваем
                                            scaler_3 = threefourth
                                            print("chart 1 pinch-out")
                                        } else {
                                            // pinch-in → уменьшаем
                                            scaler_3 = third
                                            print("chart 1 pinch-in")
                                        }
                                    }
                                }
                        )
                        .id(baseId+300000)
                        .transition(.blurReplace)
                    }
                    .NG_Card(.NG_CardStyle_Regular, theme: theme)
                    .padding(.horizontal)
                }
                .id(baseId+1000000)
                .transition(.blurReplace)
                .animation(.easeInOut(duration: initiated ? 0.5 : 3), value: baseId)
                .animation(.easeInOut(duration: 0.5), value: mode_1)
                .animation(.easeInOut(duration: 0.5), value: mode_2)
                .animation(.easeInOut(duration: 0.5), value: mode_3)
            }
            .onAppear{
                reloadTimeLearningData()
                scaler_1 = third
                scaler_2 = third
                scaler_3 = third
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    initiated = true
                }
            }
            .onChange(of: selectedArt){
                reloadTimeLearningData()
            }
            .background(theme.currentTheme.NG_LinearGradient_Background_Page)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    BackButton(action: {
                        dismiss()
                    })
            )
        }
    }
    
    func defaultTimeLearningData() {
        for theOffset in -27 ... 0 {
            let newTimeStampItem = StatsItem(id: theOffset+27, timeStamp: Date.now.stripTime().offset_inDays(theOffset), learnTime: nil, totalFormen: nil, confirmedFormen: nil, examMin: nil, examMax: nil, examAverage: nil)
            statArray.append(newTimeStampItem)
        }
        wortArten = try! viewContext.fetch(WortArt.fetchRequest()).sorted{$0.order < $1.order}
        
        let alleWortArten: [WortArt] = WortArt.get_alleWortArten(viewContext)
        
        learningPieChartData.removeAll()
        for dieArt in alleWortArten{
            var newPieChartItem = PieChartItem(wortArtName: dieArt.name_RU ?? "Неизвестно", value: 0)
            let recentTimeStats: TimeStatistics? = TimeStatistics.fetchLearningTime(in: viewContext, at: Date.now.stripTime(), forThe: dieArt)
            if let recentTimeStats = recentTimeStats{
                newPieChartItem.value = recentTimeStats.learningTime
            }
            learningPieChartData.append(newPieChartItem)
        }
        
        learningTableData.removeAll()
        for dieArt in alleWortArten{
            var learningTableItem = TableItem(wortArtName: dieArt.name_RU ?? "Неизвестно", today: 0, yesterday: 0, average: 0)
            let recentTimeStats: TimeStatistics? = TimeStatistics.fetchLearningTime(in: viewContext, at: Date.now.stripTime(), forThe: dieArt)
            if let recentTimeStats = recentTimeStats{
                learningTableItem.today = recentTimeStats.learningTime / 60.0
            }
            let gesternTimeStats: TimeStatistics? = TimeStatistics.fetchYesterdayLearningTime(in: viewContext, forThe: dieArt)
            if let gesternTimeStats = gesternTimeStats{
                learningTableItem.yesterday = gesternTimeStats.learningTime / 60.0
            }
            let averageLearningTime = TimeStatistics.fetchWeeklyAverageLearningTime(in: viewContext, forThe: dieArt)
            if let averageLearningTime = averageLearningTime{
                learningTableItem.average = averageLearningTime / 60.0
            }
            learningTableData.append(learningTableItem)
        }
    }
    
    func reloadTimeLearningData() {
        TimeStatistics.recalculate_completion(in: viewContext)
        if(statArray.count == 0){
            defaultTimeLearningData()
        }
        var theWortArt: WortArt? = nil
        if(selectedArt >= 0){
            theWortArt = wortArten[selectedArt]
        }
        for theOffset in -27 ... 0 {
            var newTimeStampItem = StatsItem(id: theOffset+27, timeStamp: Date.now.stripTime().offset_inDays(theOffset), learnTime: nil, totalFormen: nil, confirmedFormen: nil, examMin: nil, examMax: nil, examAverage: nil)
            let retrievedTimers = TimeStatistics.fetchLearningTime(in: viewContext, at: newTimeStampItem.timeStamp, forThe: theWortArt)
            if(retrievedTimers != nil){
                newTimeStampItem.learnTime = retrievedTimers!.learningTime
                newTimeStampItem.totalFormen = retrievedTimers!.totalFormen
                newTimeStampItem.confirmedFormen = retrievedTimers!.completedFormen
                if(retrievedTimers!.examCount > 0){
                    newTimeStampItem.examMin = retrievedTimers!.examMin
                    newTimeStampItem.examMax = retrievedTimers!.examMax
                    newTimeStampItem.examAverage = retrievedTimers!.examTotal / Double(retrievedTimers!.examCount)
                }
            }
            statArray[theOffset + 27] = newTimeStampItem
            print("Statistics.reloadTimeLearningData(): statArray[\(theOffset + 27)] .timeStamp:\(statArray[theOffset + 27].timeStamp) .learnTime:\(statArray[theOffset + 27].learnTime) .id:\(statArray[theOffset + 27].id) - offset:\(theOffset)")
        }
        
        
        baseId += 1
    }
}
