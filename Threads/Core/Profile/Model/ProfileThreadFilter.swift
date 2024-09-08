//
//  ProfileThreadFilter.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-07.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    case threads
    case replies
    case reposts
    
    var title: String {
        switch self {
        case .threads: return "Threads"
        case .replies: return "Replies"
        case .reposts: return "Reposts"
        }
    }
    
    var id: Int { return self.rawValue }
}
