//
//  ThreadService.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-09.
//

import Firebase
import FirebaseFirestore

//Reason this is a struct instead of a class is because we are not
//going to make this a singleton class. It's only role is to be
//fetching, uploading, increaseing/decreaseing likes, reposts, comments and shares
struct ThreadService {
    
    static func upload(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
}
