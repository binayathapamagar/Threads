//
//  AuthService.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-18.
//

import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            print(#function, "DEBUG: login() called...")
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
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
            print(#function, "DEBUG: Successfully create a new user: \(result.user.uid)")
        } catch {
            print(#function, "DEBUG: Failed to create a new user with error: \(error.localizedDescription)")
            throw error
        }
    }
    
}
