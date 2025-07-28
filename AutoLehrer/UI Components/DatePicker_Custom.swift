//
//  DatePicker_Custom.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 04.12.24.
//

import SwiftUI

struct DatePicker_Custom: View {
    @AppStorage("appLanguage") var language: String = "en"
    @Binding var highlightedDates: [Date] // Подсвеченные даты
    @Binding var closedDates: [Date]
    @Binding var openDates: [Date]
    
    @Binding var selectedDates: Set<Date> // Выбранные даты
    var allowsMultipleSelection: Bool = false // Разрешить множественный выбор

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7) // Сетка для дней недели
    
    @State private var currentMonth: Date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date())) ?? Date()

    var body: some View {
        VStack {
            // Заголовок с переключением месяца
            HStack {
                Button(action: {
                    currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                }) {
                    Image(systemName: "chevron.left")
                        .padding(8)
                }
                Text(currentMonth.formatted(.dateTime.year().month(.wide)))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .onTapGesture{
                        currentMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date())) ?? Date()
                    }
                Button(action: {
                    currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                }) {
                    Image(systemName: "chevron.right")
                        .padding(8)
                }
            }
            .padding(.bottom, 8)
            
            // Дни недели
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(orderedWeekdaySymbols(), id: \.symbol) { weekday in
                    Text(weekday.symbol)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(weekday.color)
                }
            }
            .padding(.bottom, 4)
            
            // Ячейки дней
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(Array(daysInMonth(for: currentMonth).enumerated()), id: \.offset) { index, date in
                    if let date = date {
                        Button(action: {
                            handleDateSelection(date)
                        }) {
                            Text("\(calendar.component(.day, from: date))")
                                .font(.subheadline)
                                .lineLimit(1)
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(8)
                                .background(determineBackground(for: date))
                                .cornerRadius(10)
                                .foregroundColor(determineTextColor(for: date))
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        Text("") // Пустая ячейка
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
    
    // Метод для определения всех дней месяца
    private func daysInMonth(for date: Date) -> [Date?] {
        guard let range = calendar.range(of: .day, in: .month, for: date),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return [] }
        
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        let adjustedWeekday = (firstWeekday + 5) % 7 // Смещение для начала с понедельника
        
        let leadingEmptyDays: [Date?] = Array(repeating: nil, count: adjustedWeekday) // Пустые слоты
        let monthDays = range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: firstDay)?.stripTime() }
        
        let result = leadingEmptyDays + monthDays
        //print("Days in month for \(date): \(result)")
        return result
    }
    
    // Метод для подсветки фона ячейки
    private func determineBackground(for date: Date) -> Color {
        let strippedDate = date.stripTime()
        let isSelected = selectedDates.contains(strippedDate)
        let isHighlighted = highlightedDates.contains(where: { $0.stripTime() == strippedDate })
        let isClosed = closedDates.contains(where: { $0.stripTime() == strippedDate })
        let isOpened = openDates.contains(where: { $0.stripTime() == strippedDate })
        
        if isSelected {
            return Color.blue.opacity(0.5)
        } else if isHighlighted {
            if isClosed{
                if isOpened{
                    return Color.yellow.opacity(0.5)
                }
                return Color.red.opacity(0.5)
            }
            if isOpened {
                return Color.green.opacity(0.5)
            }
            return Color.yellow.opacity(0.5)
        } else {
            return Color.clear
        }
    }
    
    // Метод для определения цвета текста
    private func determineTextColor(for date: Date) -> Color {
        let weekday = calendar.component(.weekday, from: date) // Определяем день недели
        if calendar.isDateInToday(date) {
            return .orange
        } else if weekday == 7 || weekday == 1 { // Воскресенье (1) или суббота (7) в системе Calendar
            return Color.red.opacity(0.9) // Тёмно-красный цвет
        } else {
            return .white
        }
    }
    
    // Метод для обработки выбора даты
    private func handleDateSelection(_ date: Date) {
        let strippedDate = date.stripTime()
        if allowsMultipleSelection {
            if selectedDates.contains(strippedDate) {
                selectedDates.remove(strippedDate)
            } else {
                selectedDates.insert(strippedDate)
            }
        } else {
            selectedDates = [strippedDate]
        }
    }
    
    // Дни недели с указанием цветов
    private func orderedWeekdaySymbols() -> [(symbol: String, color: Color)] {
        let shortSymbols = calendar.shortWeekdaySymbols // ["Sun", "Mon", ..., "Sat"]
        let reorderedSymbols = Array(shortSymbols[1...6] + shortSymbols[0...0]) // Понедельник начинается с [1]
        return reorderedSymbols.enumerated().map { index, symbol in
            let isWeekend = (index == 5 || index == 6) // Суббота и воскресенье
            return (symbol, isWeekend ? Color.red.opacity(0.9) : .gray)
        }
    }
}
