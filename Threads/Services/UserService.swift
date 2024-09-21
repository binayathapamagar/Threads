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
    
}
