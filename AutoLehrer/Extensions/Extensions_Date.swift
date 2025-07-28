import Foundation

extension Date {
    public static func convert_DateToString_DownToSecond(theDate: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        return dateFormatter.string(from: theDate)
    }
    public static func convert_StringToDate_DownToSecond(theString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        return dateFormatter.date(from: theString)
    }
    func offset_inDays(_ offset: Int) -> Date {
        // Используем Calendar для вычисления новой даты
        let calendar = Calendar.current
        // Добавляем или вычитаем дни
        return calendar.date(byAdding: .day, value: offset, to: self) ?? self
    }
    func offset_inMonths(_ offset: Int) -> Date {
        // Используем Calendar для вычисления новой даты
        let calendar = Calendar.current
        // Добавляем или вычитаем месяцы
        return calendar.date(byAdding: .month, value: offset, to: self) ?? self
    }
    static func get_offset_inDays(_ from: Date, _ to: Date) -> Int {
        let calendar = Calendar.current
        // Используем Calendar для вычисления разницы в днях
        let components = calendar.dateComponents([.day], from: from, to: to)
        // Возвращаем количество дней, либо 0, если разница не может быть вычислена
        return components.day ?? 0
    }
    func stripTime() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components) ?? self
    }
    func toString_withWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy, EEEE"
        if let lang = UserDefaults.standard.string(forKey: "appLanguage") {
            dateFormatter.locale = Locale(identifier: lang)
        }
        return dateFormatter.string(from: self)
    }
    func toString_withWeekday_short() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM, EEE"
        if let lang = UserDefaults.standard.string(forKey: "appLanguage") {
            dateFormatter.locale = Locale(identifier: lang)
        }
        return dateFormatter.string(from: self)
    }
    // Сериализация: Преобразование Date в строку с форматом "Число-Месяц-Год" (цифровой месяц)
    func toString_DayNumericMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // Формат: Число-Месяц-Год (месяц в цифрах)
        return dateFormatter.string(from: self)
    }
    
    // Десериализация: Преобразование строки в Date с форматом "Число-Месяц-Год" (цифровой месяц)
    static func fromString_DayNumericMonthYear(_ dateString: String?) -> Date? {
        if(dateString == nil){
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // Формат: Число-Месяц-Год (месяц в цифрах)
        return dateFormatter.date(from: dateString!)
    }
    
    static func dayOfWeek(from int: Int) -> String {
        let weekdays = DateFormatter().weekdaySymbols ?? ["Unknown"]
        let index = (int % 7) // Убеждаемся, что число в пределах 0-6
        return weekdays[index]
    }
    
    func weekDayNumber() -> Int {
        let calendar = Calendar.current
        let weekDayNumber = calendar.component(.weekday, from: self) // Воскресенье = 1, Суббота = 7
        return (weekDayNumber - 1) % 7 // Преобразуем: Воскресенье → 0, Понедельник → 1, ..., Суббота → 6
    }
    
    static func timeTo(_ date: Date) -> String {
        let calendar = Calendar.current
        let fromDate = Date.now.stripTime()
        let toDate = date.stripTime()
        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
        let days = components.day ?? 0
        return "\(days) day(s)"
    }
}
