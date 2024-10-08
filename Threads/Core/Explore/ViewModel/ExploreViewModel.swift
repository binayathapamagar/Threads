//
//  ExploreViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-07.
//

import Foundation

class ExploreViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
    
}
