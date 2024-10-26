//
//  Constants.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-16.
//

import Firebase

struct FirestoreConstants {
    
    private static let Root = Firestore.firestore()
    
    static let LikesFieldName = "likes"
    static let ThreadLikesCollectionName = "thread-likes"
    static let UserLikesCollectionName = "user-likes"
    static let ThreadIdName = "threadId"
    static let ThreadReplyOwnerUidName = "threadReplyOwnerUidName"
    
    static let UserCollection = Root.collection("users")
    
    static let ThreadCollection = Root.collection("threads")
    
    static let FollowerCollection = Root.collection("followers")
    static let FollowingCollection = Root.collection("following")
    
    static let RepliesCollection = Root.collection("replies")
    
    static let ActivityCollection = Root.collection("activity")
    
}
 
