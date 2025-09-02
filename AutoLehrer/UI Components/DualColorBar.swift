//
//  DualColorBar.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 22.08.25.
//

import SwiftUI
import CoreData

struct DualColorBar: View {
    var greenvalue: Double   // 0...1
    var yellowvalue: Double  // где меняется цвет
    var height: CGFloat = 25
    @Binding var pulseyellowtogreen: Bool
    @State private var pulsation = false

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                
                // Жёлтая часть
                Rectangle()
                    .fill(pulsation ? Color.green : Color.yellow)
                    .frame(width: geo.size.width * CGFloat(yellowvalue))
                    .animation(pulseyellowtogreen
                               ? .linear(duration: 0.5).repeatForever(autoreverses: true)
                                           : .default,
                                           value: pulsation)
                    .task(id: pulseyellowtogreen) {
                        if pulseyellowtogreen {
                            // Сначала сброс...
                            pulsation = false
                            // ...и старт цикла (repeatForever привяжется к ЭТОМУ изменению)
                            withAnimation { pulsation = true }
                        } else {
                            // Чётко гасим без анимации, чтобы остановить «на месте»
                            withAnimation(nil) { pulsation = false }
                        }
                    }

                // Зелёная часть
                Rectangle()
                    .fill(Color.green)
                    .frame(width: geo.size.width * CGFloat(greenvalue))
            }
            .onChange(of: pulseyellowtogreen){ old, new in
                //print("DualColorBar.pulseyellowtogreen: \(old) -> \(new)")
            }
            .onAppear{
                //print("DualColorBar.pulseyellowtogreen: \(pulseyellowtogreen)")
            }
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: height/2))
    }
}
