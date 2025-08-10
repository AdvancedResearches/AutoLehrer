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
    var deutschesBeispeil: String?
    var russischesBeispeil: String?
    @Binding var result: Int
    var condensed: Bool = true
    
    var body: some View {
        VStack {
            if(deutschesSeite){
                Text(deutschesWorte)
                    .NG_textStyling(.NG_TextStyle_Text_Regular, glare: true, theme: theme)
                    .padding(.top, condensed ? 0 : 10)
                    .if(deutschesBeispeil == nil){ view in
                            view.padding(.bottom, condensed ? 0 : 10)
                    }
                if(deutschesBeispeil != nil){
                    Text("\"\(deutschesBeispeil!)\"")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        .padding(.leading, 10)
                        .padding(.bottom, condensed ? 0 : 10)
                }
            }else{
                Text(russischesWorte)
                    .NG_textStyling(.NG_TextStyle_Text_Regular, glare: true, theme: theme)
                    .padding(.top, condensed ? 0 : 10)
                    .if(russischesBeispeil == nil){ view in
                            view.padding(.bottom, condensed ? 0 : 10)
                    }
                if(russischesBeispeil != nil){
                    Text("\"\(russischesBeispeil!)\"")
                        .NG_textStyling(.NG_TextStyle_Text_Regular, theme: theme)
                        .padding(.leading, 10)
                        .padding(.bottom, condensed ? 0 : 10)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .NG_Card(result==0 ? .NG_CardStyle_Regular : result==1 ? .NG_CardStyle_Green : .NG_CardStyle_Red, theme: theme)
        .onTapGesture {
            deutschesSeite.toggle()
        }
    }
}
