//
//  TextField_Float.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 05.02.25.
//

import SwiftUI

struct TextField_Float: View {
    @AppStorage("appLanguage") var language: String = "en"
    @Binding var value: Float
    @Binding var requestToUpdate: Int
    @State private var inputText: String
    @State private var isValid: Bool = true
    @EnvironmentObject var theme: ThemeManager
    
    var placeholder: String
    var maxWidth: CGFloat = 100
    
    init(value: Binding<Float>, requestToUpdate: Binding<Int>, placeholder: String = "Enter value", maxWidth: CGFloat = 100) {
        self._value = value
        self._inputText = State(initialValue: String(value.wrappedValue).replacingOccurrences(of: ".", with: ","))
        self.placeholder = placeholder
        self.maxWidth = maxWidth
        self._requestToUpdate = requestToUpdate
    }
    
    var body: some View {
        TextField(placeholder, text: $inputText)
        /*
            .padding(5)
            .background(MasterColorSchema.color_bright_most)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .foregroundColor(isValid ? MasterColorSchema.color_dark_most : MasterColorSchema.color_dark_red)
         */
            .NG_textFieldStyling(.NG_TextField_Regular, theme: theme)
            .keyboardType(.decimalPad)
            .frame(maxWidth: maxWidth)
            .environment(\.colorScheme, .light) // ✅ Принудительно включаем светлую тему
            .onChange(of: inputText) { newValue in
                let filteredValue = newValue.replacingOccurrences(of: ",", with: ".")
                if let floatValue = Float(filteredValue) {
                    isValid = true
                    value = floatValue
                } else {
                    isValid = false
                }
            }
            .onChange(of: requestToUpdate) { newValue in
                // ✅ Обновляем текстовое представление при изменении `value` извне
                inputText = String(value).replacingOccurrences(of: ".", with: ",")
            }
            .onAppear {
                inputText = String(value).replacingOccurrences(of: ".", with: ",")
            }
    }
}
