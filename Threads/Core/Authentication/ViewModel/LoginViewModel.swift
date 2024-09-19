//
//  LoginViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-19.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var showLoadingSpinner = false
    
    var fieldsAreEmpty: Bool {
        email.isEmpty || password.isEmpty
    }
    
    @MainActor
    func login() async throws {
        showLoadingSpinner = true
        
        defer {
            showLoadingSpinner = false
        }
        
        do {
            try await AuthService.shared.login(
                withEmail: email,
                password: password
            )
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
        
}
