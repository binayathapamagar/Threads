//
//  ContentView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-08-20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabBarView()
            } else {
                LoginView()
            }
        }//Group
    }
}

#Preview {
    ContentView()
}
