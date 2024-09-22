//
//  ViewExtension.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-21.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
