//
//  DeleteConfirmationPopup.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 29.01.25.
//

import SwiftUI

struct ConfirmationPopup: View {
    @EnvironmentObject var theme: ThemeManager
    @AppStorage("appLanguage") var language: String = "ru"
    @Binding var isPresented: Bool
    var header: String?
    var yesSelection: String?
    var noSelection: String?
    var hasYes: Bool = true
    var hasNo: Bool = true

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
                VStack(spacing: 16) {
                    Text(actualHeader)
                        .NG_textStyling(.NG_TextStyle_Text_Regular, .NG_TextColor_Red, theme: theme)
                    
                    Text(message)
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    HStack(spacing: 20) {
                        if(hasNo){
                            NG_Button(title: actualNoSelection, style: .NG_ButtonStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                                dismiss()
                            })
                        }
                        if(hasYes){
                            NG_Button(title: actualYesSelection, style: .NG_ButtonStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), action: {
                                onConfirm()
                                dismiss()
                            })
                        }
                    }
                    .frame(maxWidth: 300)
                }
                .padding()
                .frame(width: 300)
        }
    }
    
    private func dismiss() {
        isPresented = false
        onCancel?()
    }
}
