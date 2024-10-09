//
//  UserService.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-20.
//

import FirebaseAuth
import FirebaseFirestore

class UserService {
    
    private var USERS_COLLECTION_NAME = "users"
    
    //No the firebase user and our own custom user model that will be
    //used to populate our app
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection(USERS_COLLECTION_NAME).document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        
        print(#function, "DEBUG: User is \(user)")
    }
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap({ try? $0.data(as: User.self) })
        return users.filter({ $0.id != currentUserUid })
    }
    
    func resetCurrentUser() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection(USERS_COLLECTION_NAME).document(currentUserUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
    }
    
}
