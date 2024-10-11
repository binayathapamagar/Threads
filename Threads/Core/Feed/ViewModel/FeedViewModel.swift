//
//  FeedViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-10.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var threads = [Thread]()
    
    init() {
        Task { try await fetchThreads() }
    }
    
    func fetchThreads() async throws {
        self.threads = try await ThreadService.fetchThreads()
        try await fetchUserForThread()
    }
    
    private func fetchUserForThread() async throws {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let threadOwner = try await UserService.fetchUser(with: ownerUid)
            
            threads[i].user = threadOwner
        }
    }
    
}
