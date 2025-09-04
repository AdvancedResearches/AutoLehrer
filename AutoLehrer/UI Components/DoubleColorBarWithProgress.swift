//
//  DualColorBar.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 22.08.25.
//

import SwiftUI
import CoreData

struct DoubleColorBarWithProgress: View {
    var progressValue: Double
    var topValue: Double
    var bottomValue: Double
    var progressColor: Color
    var topColor: Color
    var bottomColor: Color
    var height: CGFloat = 25
    var progressRatio: Double = 0.25
    @Binding var highlightColor: Color

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                
                // bottom level
                Rectangle()
                    .fill(bottomColor)
                    .frame(width: geo.size.width * CGFloat(bottomValue))
                
                // middle level
                Rectangle()
                    .fill(topColor)
                    .frame(width: geo.size.width * CGFloat(topValue))

                // top level (progress line only bottom third)
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(progressColor)
                        .frame(
                            width: geo.size.width * CGFloat(progressValue),
                            height: geo.size.height * progressRatio
                        )
                }
            }
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: height/2))
        .overlay(
            RoundedRectangle(cornerRadius: height/2)
                .stroke(highlightColor, lineWidth: 2)
        )
    }
}
