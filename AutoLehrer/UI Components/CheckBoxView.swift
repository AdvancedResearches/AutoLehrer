//
//  CheckBoxView.swift
//  DerTermin
//
//  Created by Алексей Хурсевич on 11.09.24.
//

import SwiftUI
import CoreData

// Вспомогательный компонент для отображения чекбокса
struct CheckBoxView: View {
    @Binding var isChecked: Bool
    var isPlaceholder: Bool = false
    @EnvironmentObject var theme: ThemeManager

    var body: some View {
        Button(action: {
            if(!isPlaceholder){
                isChecked.toggle()
            }
        }) {
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .if(isPlaceholder){ view in
                    view.NG_iconStyling(.NG_IconStyle_Transparent, isDisabled: .constant(true), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                }
                .if(!isPlaceholder){ view in
                    view
                        .if(isChecked){ view in
                        view.NG_iconStyling(.NG_IconStyle_Green, isDisabled: .constant(false), isHighlighting: .constant(true), isPulsating: .constant(false), theme: theme)
                    }
                    .if(!isChecked){ view in
                        view.NG_iconStyling(.NG_IconStyle_Red, isDisabled: .constant(false), isHighlighting: .constant(false), isPulsating: .constant(false), theme: theme)
                    }
                }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}
