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
        if currentUser == nil {
            Task { try await fetchCurrentUser() }
        }
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
    
    static func fetchUser(with uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func resetCurrentUser() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfile(with data: [String: Any]) async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        try await Firestore.firestore().collection(USERS_COLLECTION_NAME).document(currentUserUid).updateData(data)
        
        if let updatedUser = try await fetchUpdatedUser(with: currentUserUid) {
            self.currentUser = updatedUser
        }
    }

    private func fetchUpdatedUser(with userId: String) async throws -> User? {
        let snapshot = try await Firestore.firestore().collection(USERS_COLLECTION_NAME).document(userId).getDocument()
        return try snapshot.data(as: User.self)
    }

    
}
