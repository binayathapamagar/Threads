//
//  ThreadsApp.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-08-20.
//

import SwiftUI
import FirebaseCore

@main
struct ThreadsApp: App { 
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
