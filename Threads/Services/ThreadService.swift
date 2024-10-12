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
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self )})
    }
    
    static func fetchUserThreads(with uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .whereField("ownerUid", isEqualTo: uid) //When we use whereField query, we can't order the data by a field.
            .getDocuments()
        
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self )})
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }) //newer timestamps appear before older ones
    }
    
}
