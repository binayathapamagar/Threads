//
//  DeveloperPreview.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-07.
//

import SwiftUI
import Firebase

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
    
    lazy var thread = Thread(
        ownerUid: NSUUID().uuidString,
        content: "This is a test thread for the test user to use for development purposes.",
        timestamp: Timestamp(),
        likes: 100,
        reposts: 1000,
        shares: 200,
        replyCount: 250,
        user: user
    )
    
    lazy var threadReply = ThreadReply(
        threadId: NSUUID().uuidString,
        replyText: "This is a test thread reply for the test user to use for development purposes.",
        threadReplyOwnerUid: NSUUID().uuidString,
        threadOwnerUid: NSUUID().uuidString,
        timestamp: Timestamp(),
        thread: thread,
        replyUser: user
    )
}
