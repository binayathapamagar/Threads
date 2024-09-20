//
//  AuthService.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-18.
//

import FirebaseAuth

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser //Will be nil if the user is not logged in.
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            print(#function, "DEBUG: login() called...")
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print(#function, "DEBUG: Successfully login: \(result.user.uid)")
        } catch {
            print(#function, "DEBUG: Failed to login with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    //Any time we have a function that has an asynce throws, we have to wrap it in a do catch block.
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        print(#function, "DEBUG: createUser() called...")
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print(#function, "DEBUG: Successfully create a new user: \(result.user.uid)")
        } catch {
            print(#function, "DEBUG: Failed to create a new user with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() {
        print(#function, "DEBUG: signOut() called...")
        try? Auth.auth().signOut() //Signs the user on the Firebase backend
        userSession = nil //Signs the user out locally and updates the routing.
    }
    
}
