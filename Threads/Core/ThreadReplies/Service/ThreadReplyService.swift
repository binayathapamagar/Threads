//
//  ThreadReplyService.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-21.
//

import Firebase
import FirebaseFirestore

struct ThreadReplyService {
    
    static func uploadThreadReply(_ threadReply: ThreadReply, to thread: Thread) async throws {
        guard let replyData = try? Firestore.Encoder().encode(threadReply) else { return }
        async let _ = try await FirestoreConstants.RepliesCollection.document().setData(replyData)
        async let _ = try await FirestoreConstants.ThreadCollection.document(thread.id).updateData(
            [
                "replyCount": thread.replyCount + 1
            ]
        )
    }
    
}
