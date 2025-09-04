//
//  DualColorBar.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 22.08.25.
//

import SwiftUI
import CoreData

struct SimpleDoubleColorLine: View {
    var topValue: Double
    var bottomValue: Double
    var topColor: Color
    var bottomColor: Color
    var height: CGFloat = 5

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

            }
        }
        .frame(height: height)
    }
}
