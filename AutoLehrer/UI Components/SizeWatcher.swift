//
//  SizeWatcher.swift
//  AutoLehrer
//
//  Created by Алексей Хурсевич on 22.08.25.
//

import SwiftUI
import CoreData

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizeAware<Content: View>: View {
    let onChange: (CGSize) -> Void
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: geo.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
