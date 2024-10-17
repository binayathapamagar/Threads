//
//  UserContentListViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-11.
//

import Foundation

@MainActor
class UserContentListViewModel: ObservableObject {
    @Published var threads = [Thread]()
    @Published var emptyMessage: String = ""
    @Published var selectedFilter: ProfileThreadFilter = .threads
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserThreads() }
    }
    
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(with: user.id)
        
        for i in 0..<threads.count {
            threads[i].user = self.user
        }
        
        self.threads = threads
        
        if threads.isEmpty {
            emptyMessage = selectedFilter.emptyMessage
        } else {
            emptyMessage = ""
        }
    }
    
    func fetchUserReplies() async throws {
        threads = []
        if threads.isEmpty {
            emptyMessage = selectedFilter.emptyMessage
        } else {
            emptyMessage = ""
        }
    }
    
    func fetchUserReposts() async throws {
        threads = []
        if threads.isEmpty {
            emptyMessage = selectedFilter.emptyMessage
        } else {
            emptyMessage = ""
        }
    }
    
    func fetchUserLikes() async throws {
        self.threads = try await ThreadService.fetchUserLikedThreads(with: user.id)
        if threads.isEmpty {
            emptyMessage = selectedFilter.emptyMessage
        } else {
            emptyMessage = ""
        }
    }
    
    func updateFilter(with newFilterValue: ProfileThreadFilter) {
        selectedFilter = newFilterValue
        
        Task {
            switch selectedFilter {
            case .threads:
                try await fetchUserThreads()
            case .replies:
                try await fetchUserReplies()
            case .reposts:
                try await fetchUserReposts()
            case .likes:
                try await fetchUserLikes()

            }
        }
    }
    
}
