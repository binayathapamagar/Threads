//
//  RegistrationViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-13.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func createUser() async throws {
        print(#function, "DEBUG: Create user function called...")
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullname: fullName,
            username: username
        )
    }
    
}
