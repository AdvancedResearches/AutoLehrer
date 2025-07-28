//
//  DeleteConfirmationPopup.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 29.01.25.
//

import SwiftUI

struct ConfirmationPopup: View {
    @EnvironmentObject var theme: ThemeManager
    @AppStorage("appLanguage") var language: String = "en"
    @Binding var isPresented: Bool
    var header: String?
    var yesSelection: String?
    var noSelection: String?

    var actualHeader: String {
        header ?? "Confirm Deletion".localized(for: language)
    }
    var actualYesSelection: String {
        yesSelection ?? "Delete".localized(for: language)
    }
    var actualNoSelection: String {
        noSelection ?? "Cancel".localized(for: language)
    }
    
    var message: String
    var onConfirm: () -> Void
    var onCancel: (() -> Void)? = nil
    
    var body: some View {
        if isPresented {                
                // Контейнер с сообщением и кнопками
                VStack(spacing: 16) {
                    Text(actualHeader)
                    /*
                        .font(.title)
                        .color_dark_bad_glare(blinking: false, faded: false)
                     */
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                    
                    Text(message)
                        //.font(.body)
                        //.color_dark_most(blinking: false, faded: false)
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack(spacing: 20) {
                        /*
                        Button(action: {
                            dismiss()
                        }) {
                            Text(actualNoSelection)
                                .customButtonStyle(type: .normal, isActive: true)
                        }
                         */
                        NG_Button(title: actualNoSelection, style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            dismiss()
                        })
                        /*
                        Button(action: {
                            onConfirm()
                            dismiss()
                        }) {
                            Text(actualYesSelection)
                                .customButtonStyle(type: .no, isActive: true)
                        }
                         */
                        NG_Button(title: actualYesSelection, style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                            onConfirm()
                            dismiss()
                        })
                    }
                    .frame(maxWidth: 300)
                }
                .padding()
                .frame(width: 300)
                /*.background(MasterColorSchema.color_bright_most.opacity(0.9))
                .cornerRadius(12)*/
                //.NG_Card(.NG_CardStyle_Regular)
        }
    }
    
    private func dismiss() {
        isPresented = false
        onCancel?()
    }
}
