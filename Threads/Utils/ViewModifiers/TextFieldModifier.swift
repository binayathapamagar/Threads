//
//  TextFieldModifiers.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .padding(.horizontal, 24)
    }
    
}
