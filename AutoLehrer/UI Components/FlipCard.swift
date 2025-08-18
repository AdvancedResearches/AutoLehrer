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
    @Binding var elapsedTime: Double
    @Binding var passedTime: Double
    @Binding var completed: Bool
    @Binding var notStarted: Bool
    
    private var secondsLabel: String { "сек." }
    private var remainingTimeString: String {
        let remaining = max(elapsedTime - passedTime, 0)
        return String(format: "%.1f", remaining)
    }
    
    private var progressColor: Color {
        let remaining = elapsedTime - passedTime
        if remaining > 3 {
            return .green
        } else if remaining > 1 {
            return .yellow
        } else {
            return .red
        }
    }
    
    var body: some View {
        ZStack{
            VStack {
                HStack{
                    Spacer()
                    Text("\(remainingTimeString) \(secondsLabel)")
                        .NG_textStyling(.NG_TextStyle_Text_Small, theme: theme)
                }
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
                ProgressView(value: passedTime, total: elapsedTime)
                    .progressViewStyle(.linear)
                    .padding(.horizontal, 8)
                    .frame(height: 4)
                    .animation(.linear(duration: 0.1), value: passedTime)
                    .tint(progressColor)
            }
            .frame(maxWidth: .infinity)
            .NG_Card(result==0 ? .NG_CardStyle_Regular : result==1 ? .NG_CardStyle_Green : .NG_CardStyle_Red, noShadow: result != 0 || notStarted, theme: theme)
            .onTapGesture {
                deutschesSeite.toggle()
            }
        }
    }
}
