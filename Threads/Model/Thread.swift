//
//  Thread.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-09.
//

import Firebase
import FirebaseFirestore

struct Thread: Identifiable, Codable {
    //Using the document id as the threadId and it has to be an optional when we use the property wrapper
    @DocumentID var threadId: String?
    let ownerUid: String
    let content: String
    let timestamp: Timestamp//From Firebase
    
    var likes: Int
    var comments: Int
    var reposts: Int
    var shares: Int
    
    var user: User?
    var imageUrl: String?
    
    //Need this id for the Identifiable protocol
    var id: String {
        threadId ?? NSUUID().uuidString
    }
    
}
