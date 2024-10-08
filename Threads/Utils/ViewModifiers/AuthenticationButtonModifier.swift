//
//  AuthenticationButtonModifier.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct AuthenticationButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.appSecondary)
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(.appPrimary)
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .padding(.vertical)
            .padding(.horizontal, 24)
    }
    
}
