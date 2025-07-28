//
//  Extensions_Color.swift
//  GymRat
//
//  Created by Алексей Хурсевич on 20.06.25.
//

import Foundation
import SwiftUI

extension Color {
    static func colorFromColorWheel(index: Int, total: Int, saturation: Double) -> Color {
        guard total > 0 else { return .gray } // защита от деления на ноль

        let hue = Double(index % total) / Double(total) // нормализуем [0, 1)
        return Color(hue: hue, saturation: saturation, brightness: 1)
    }
}
