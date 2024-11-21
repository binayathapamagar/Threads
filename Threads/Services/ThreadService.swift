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
}

// MARK: - Threads

extension ThreadService {
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await FirestoreConstants
            .ThreadCollection
            .order(by: FirestoreConstants.TimeStampFieldName, descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self )})
    }
    
    static func fetchThread(threadId: String) async throws -> Thread {
        let snapshot = try await FirestoreConstants
            .ThreadCollection
            .document(threadId)
            .getDocument()
        
        return try snapshot.data(as: Thread.self)
    }
    
    static func fetchUserThreads(with uid: String) async throws -> [Thread] {
        let snapshot = try await FirestoreConstants
            .ThreadCollection
            .whereField(FirestoreConstants.OwnerUidFieldName, isEqualTo: uid) //When we use whereField query, we can't order the data by a field.
            .getDocuments()
        
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self )})
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }) //newer timestamps appear before older ones
    }
}

// MARK: - Replies
extension ThreadService {
    static func fetchThreadReplies(forUser user: User) async throws -> [ThreadReply] {
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField(FirestoreConstants.ThreadReplyOwnerUidFieldName, isEqualTo: user.id)
            .getDocuments()
        
        var replies = snapshot.documents.compactMap({ try? $0.data(as: ThreadReply.self )})
        
        for i in 0..<replies.count {
            replies[i].replyUser = user//All of the replies belong to this user.
        }
        
        return replies
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
    
    static func fetchUserLikedThreads(with uid: String) async throws -> [Thread] {
        // Step 1: Fetch all the thread IDs from the user-likes collection
        let snapshot = try await FirestoreConstants
            .UserCollection
            .document(uid)
            .collection(FirestoreConstants.UserLikesCollectionName)
            .getDocuments()
        
        // Step 2: Extract thread IDs from the snapshot
        let threadIds = snapshot.documents.map { $0.documentID }
        
        // If there are no liked threads, return an empty array
        guard !threadIds.isEmpty else { return [] }
        
        // Step 3: Fetch all the liked threads from the Threads collection
        var threads = [Thread]()
        
        // Parallel fetching for threads
        try await withThrowingTaskGroup(of: (Thread, User?).self) { group in
            for threadId in threadIds {
                group.addTask {
                    // Fetch the thread by ID
                    let threadDoc = try await FirestoreConstants
                        .ThreadCollection
                        .document(threadId)
                        .getDocument()
                    
                    // Decode the thread
                    let thread = try threadDoc.data(as: Thread.self)
                    
                    // Fetch the user (thread owner) for each thread
                    let threadOwner = try await UserService.fetchUser(with: thread.ownerUid)
                    
                    // Return both thread and user
                    return (thread, threadOwner)
                }
            }
            
            // Step 4: Collect the results
            for try await (thread, threadOwner) in group {
                var updatedThread = thread
                updatedThread.user = threadOwner // Assign the fetched user to the thread
                threads.append(updatedThread)
            }
        }
        
        // Step 5: Sort threads by timestamp (optional)
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
}
