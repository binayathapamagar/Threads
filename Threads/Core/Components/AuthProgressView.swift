//
//  AuthProgressView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-19.
//

import SwiftUI

struct AuthProgressView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.5)
            .frame(width: 45, height: 45)
            .padding()
            .tint(.black)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

#Preview {
    AuthProgressView()
}
