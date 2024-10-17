//
//  ThreadService.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-09.
//

import Firebase
import FirebaseAuth
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
        let snapshot = try await FirestoreConstants
            .ThreadCollection
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self )})
    }
    
    static func fetchUserThreads(with uid: String) async throws -> [Thread] {
        let snapshot = try await FirestoreConstants
            .ThreadCollection
            .whereField("ownerUid", isEqualTo: uid) //When we use whereField query, we can't order the data by a field.
            .getDocuments()
        
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self )})
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }) //newer timestamps appear before older ones
    }
    
}


// MARK: - Likes

extension ThreadService {
    static func likeThread(_ thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let threadRef = FirestoreConstants.ThreadCollection.document(thread.id)
        
        //NOTE: async let allows you to initiate multiple asynchronous operations in parallel (concurrently), and you can wait for their results later in the code. This improves performance by allowing tasks to run concurrently instead of waiting for each task to finish (suspension due to the await) before starting the next one.
        
        //Saving a blank data as we only need the user's id as the document id in the collection.
        async let _ = try await threadRef.collection(FirestoreConstants.ThreadLikesCollectionName).document(uid).setData([:])
        async let _ = try await threadRef.updateData(
            [
                FirestoreConstants.LikesFieldName: thread.likes + 1
            ]
        )
        //Saving a blank data as we only need the threads's id as the document id in the collection.
        async let _ =  try await FirestoreConstants
            .UserCollection
            .document(uid)
            .collection(FirestoreConstants.UserLikesCollectionName)
            .document(thread.id)
            .setData([:])
    }
    
    static func unlikeThread(_ thread: Thread) async throws {
        guard thread.likes > 0 else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let threadRef = FirestoreConstants.ThreadCollection.document(thread.id)
        
        async let _ = try await threadRef.collection(FirestoreConstants.ThreadLikesCollectionName).document(uid).delete()
        async let _ = try await threadRef.updateData(
            [
                FirestoreConstants.LikesFieldName: thread.likes - 1
            ]
        )
        async let _ =  try await FirestoreConstants
            .UserCollection
            .document(uid)
            .collection(FirestoreConstants.UserLikesCollectionName)
            .document(thread.id)
            .delete()
    }
    
    static func userHasLikedThread(_ thread: Thread) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }

        let snapshot = try await FirestoreConstants
            .UserCollection
            .document(uid)
            .collection(FirestoreConstants.UserLikesCollectionName)
            .document(thread.id)
            .getDocument()
        
        return snapshot.exists
    }
}
