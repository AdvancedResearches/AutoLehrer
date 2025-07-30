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
    
    @Binding var deutschesSeite: Bool
    var deutschesWorte: String
    var russischesWorte: String
    @Binding var result: Int
    
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
        .NG_Card(result==0 ? .NG_CardStyle_Regular : result==1 ? .NG_CardStyle_Green : .NG_CardStyle_Red, theme: theme)
        .onTapGesture {
            deutschesSeite.toggle()
        }
    }
}
