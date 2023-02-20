//
//  View+ModefiersForToast.swift
//  MyYelp
//
//  Created by EngineGu on 2022/12/7.
//

import SwiftUI

extension View {
    func toast<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
        Toast(
            isPresented: isPresented,
            presenter: { self },
            content: content
        )
    }
}
