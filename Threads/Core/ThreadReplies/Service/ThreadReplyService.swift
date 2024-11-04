//
//  ThreadReplyService.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-21.
//

import Firebase
import FirebaseFirestore

enum ReplyType {
    case thread
    case user
}

struct ThreadReplyService {
    
    static func uploadThreadReply(_ threadReply: ThreadReply, to thread: Thread) async throws {
        guard let replyData = try? Firestore.Encoder().encode(threadReply) else { return }
        
        async let _ = try await FirestoreConstants.RepliesCollection.document().setData(replyData)
        async let _ = try await FirestoreConstants.ThreadCollection.document(thread.id).updateData(
            [
                FirestoreConstants.ThreadReplyCountName: thread.replyCount + 1
            ]
        )
    }
    
    static func fetchReplies(for thread: Thread? = nil, for user: User? = nil, replyType: ReplyType) async throws -> [ThreadReply] {
        let id: String = {
            switch replyType {
            case .thread:
                return thread?.id ?? ""
            case .user:
                return user?.id ?? ""
            }
        }()
        
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField(
                replyType == .thread ? FirestoreConstants.ThreadIdName : FirestoreConstants.ThreadReplyOwnerUidName,
                isEqualTo: id
            )
            .getDocuments()
        
        return snapshot.documents.compactMap { try? $0.data(as: ThreadReply.self) }
    }
    
}
