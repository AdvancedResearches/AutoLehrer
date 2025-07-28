//
//  AppWizard.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 30.03.25.
//

import Foundation
import SwiftUI
import CoreData

struct Component_AppWizard {
    func mainMenuAdvice(context: NSManagedObjectContext, theme: ThemeManager) -> some View {
        let message = mainMenuRecalc(context: context)
        return Group {
            if let message = message {
                HStack {
                    Text(message)
                        .multilineTextAlignment(.leading)
                        .NG_textStyling(.NG_TextStyle_AppWizard, theme: theme)
                    Spacer()
                }
                //.cardStyle(backgroundColor: Color.appWizardBackground, shadowColor: Color.appWizardShadow, borderDark: Color.appWizardBorderDark, borderBright: Color.appWizardBorderBright)
                .NG_Card(.NG_CardStyle_AppWizard, theme: theme)
                .padding()
            }
        }
        //.frame(maxWidth: .infinity, alignment: .leading)
        //.background(MasterColorSchema.color_dark_gray.opacity(0.7))
        //.color_bright_default(blinking: false, faded: false)
        //.border(MasterColorSchema.color_bright_orange)
    }
    
    private func mainMenuRecalc(context: NSManagedObjectContext) -> String? {
        return nil
    }
}
