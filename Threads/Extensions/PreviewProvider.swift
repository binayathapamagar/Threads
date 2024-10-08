//
//  DeveloperPreview.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-07.
//

import SwiftUI

//extension PreviewProvider {
//    static var dev: DeveloperPreview {
//        return DeveloperPreview.shared
//    }
//}

class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    
    let user = User(
        id: UUID().uuidString,
        username: "leo_messi",
        fullName: "Leo Andres Messi",
        email: "messi@gmail.com",
        joinedDate: "July 23, 2024"
    )
    
}
