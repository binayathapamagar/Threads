//
//  CircularProfileview.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-07.
//

import SwiftUI

struct CircularProfileView: View {
    
    var body: some View {
        Image(.messi)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    CircularProfileView()
}
