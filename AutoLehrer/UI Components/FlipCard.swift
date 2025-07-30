//
//  FlipCard.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 29.07.25.
//

import Foundation
import SwiftUI

struct FlipCard: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") var language: String = "ru"
    @EnvironmentObject var theme: ThemeManager
    
    @State var deutschesSeite: Bool
    var deutschesWorte: String
    var russischesWorte: String
    
    var body: some View {
        VStack {
            if(deutschesSeite){
                Text(deutschesWorte)
                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
            }else{
                Text(russischesWorte)
                    .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
            }
        }
        .frame(maxWidth: .infinity)
        .NG_Card(.NG_CardStyle_Regular, theme: theme)
        .onTapGesture {
            deutschesSeite.toggle()
        }
    }
}
