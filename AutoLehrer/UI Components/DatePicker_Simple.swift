import SwiftUI

struct DatePicker_Simple: View {
    @AppStorage("appLanguage") var language: String = "ru"
    @Binding var selectedDate: Date
    var label: String = "Выберите дату"
    var backgroundColor: Color = Color.blue
    var textColor: Color = Color.white

    @State private var isPresented: Bool = false

    var body: some View {
        /*
        Button(action: {
            isPresented.toggle()
        }) {
            Text("\(formattedDate)")
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(MasterColorSchema.color_dark_1.opacity(0.3))
                .foregroundColor(MasterColorSchema.color_bright_1)
                .cornerRadius(8)
        }
         */
        NG_Button(title: "\(formattedDate)", style: .NG_ButtonStyle_DatePicker, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
            isPresented.toggle()
        }, textScroll: true, narrowHorizontalPadding: true)
        .sheet(isPresented: $isPresented) {
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(.custom)
                    .padding()
                
                /*
                Button(action: {
                    isPresented = false
                }) {
                    Text("Pick Date".localized(for: language))
                        .customButtonStyle(type: .yes, isActive: true)
                }
                 */
                NG_Button(title: "Pick Date".localized(for: language), style: .NG_ButtonStyle_Regular, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(true), action: {
                    isPresented = false
                })
            }
            .padding(3)
            /*
            .background(
                RoundedRectangle(cornerRadius: 12) // Закругляем углы
                    .fill(MasterColorSchema.color_dark_1.opacity(0.7))
            )
             */
            .NG_sheetFormatting()
            .padding(10)
            //.sheetContentFormatting(transparent: true)
        }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
}

extension DatePickerStyle where Self == CustomDatePickerStyle {
    static var custom: CustomDatePickerStyle { CustomDatePickerStyle() }
}

struct CustomDatePickerStyle: DatePickerStyle {
    @EnvironmentObject var theme: ThemeManager
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            /*
            configuration.label
                .font(.subheadline)
                .foregroundColor(MasterColorSchema.color_bright_1)
            */

            DatePicker("", selection: configuration.$selection, displayedComponents: [.date]) // Используем $selection
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(theme.currentTheme.NG_Color_DatePicker_Background))
        }
        .padding()
    }
}
