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
}

struct StatisticsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var theme: ThemeManager
    
    @AppStorage("appLanguage") var language: String = "ru"
    
    @State var currentTheme: Theme_Style = .regular
    
    @State var statArray: [StatsItem] = []
    
    let allThemes: [Theme_Style] = [.regular, .herren, .frauen, .cyberpunk, .retrowave]
    
    var body: some View{
        NavigationStack {
            VStack {
                VStack{
                    HStack{
                        Text("Время изучения")
                            .NG_textStyling(.NG_TextStyle_SectionHeader, theme: theme)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    let chartFromDate: Date = (statArray.first?.timeStamp ?? Date()).offset_inDays(-2)
                    let chartToDate: Date = (statArray.last?.timeStamp ?? Date()).offset_inDays(2)
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
                                .interpolationMethod(.stepEnd)
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
                    .frame(maxHeight: UIScreen.main.bounds.height / 3)
                }
                .NG_Card(.NG_CardStyle_Regular, theme: theme)
                .padding(.horizontal)
                /*
                 Chart {
                     ForEach(sortedMuscles, id: \.self) { muscle in
                         if (!hiddenMuscles.contains(muscle)){
                             if let points = muscle_chart_data_points[muscle] {
                                 ForEach(points) { point in
                                     if let fatigue = point.fatigue {
                                         LineMark(
                                             x: .value("Date", point.date),
                                             y: .value("Fatigue", Float(Float(fatigue.id)/Float(3.0))),
                                             series: .value("Fatigue", muscle.fullName)
                                         )
                                         .foregroundStyle(point.fatigueColor)
                                         .interpolationMethod(.stepEnd)
                                         .lineStyle(StrokeStyle(lineWidth: 2 + CGFloat(point.scale*2)))
                                         PointMark(
                                             x: .value("Date", point.date),
                                             y: .value("Fatigue", Float(Float(fatigue.id)/Float(3.0)))
                                         )
                                         .symbol {
                                             Rectangle()
                                                 .foregroundColor(point.fatigueColor)
                                                 .frame(width: 20 + CGFloat(point.scale*4), height: 20 + CGFloat(point.scale*4))
                                         }
                                     }
                                     if let development = point.development {
                                         LineMark(
                                             x: .value("Date", point.date),
                                             y: .value("Development", development),
                                             series: .value("Development", muscle.fullName)
                                         )
                                         .foregroundStyle(point.developmentColor)
                                         .interpolationMethod(.stepEnd)
                                         .lineStyle(StrokeStyle(lineWidth: 2 + CGFloat(point.scale*2)))
                                         
                                         PointMark(
                                             x: .value("Date", point.date),
                                             y: .value("Development", development)
                                         )
                                         .foregroundStyle(point.developmentColor)
                                         .symbolSize(100 + CGFloat(point.scale*100))
                                     }
                                 }
                             }
                         }
                     }
                 }
                 .chartXScale(domain: showStart...showEnd)
                 .chartYScale(domain: 0...1.5)
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
                 */
                Spacer()
            }
            .onAppear{
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
            let newTimeStampItem = StatsItem(id: theOffset+27, timeStamp: Date.now.stripTime().offset_inDays(theOffset), learnTime: nil)
            statArray.append(newTimeStampItem)
        }
    }
    
    func reloadTimeLearningData() {
        if(statArray.count == 0){
            defaultTimeLearningData()
        }
        for theOffset in -27 ... 0 {
            var newTimeStampItem = StatsItem(id: theOffset+27, timeStamp: Date.now.stripTime().offset_inDays(theOffset), learnTime: nil)
            let retrievedTimers = TimeStatistics.fetchLearningTime(in: viewContext, at: newTimeStampItem.timeStamp, forThe: nil)
            if(retrievedTimers != nil){
                newTimeStampItem.learnTime = retrievedTimers!.learningTime
            }
            statArray[theOffset + 27] = newTimeStampItem
            print("Statistics.reloadTimeLearningData(): statArray[\(theOffset + 27)] .timeStamp:\(statArray[theOffset + 27].timeStamp) .learnTime:\(statArray[theOffset + 27].learnTime) .id:\(statArray[theOffset + 27].id) - offset:\(theOffset)")
        }
    }
}
