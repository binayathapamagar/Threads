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
    @Published var replies = [ThreadReply]()
    @Published var emptyMessage: String = ""
    @Published var selectedFilter: ProfileThreadFilter = .threads
    
    let user: User
    
    init(user: User) {
        self.user = user
        
        //Fetching the user's threads and replies concurrently instead of sequentially by using different tasks.
        Task { try await fetchUserThreads() }
        Task { try await fetchUserReplies() }
    }
    
    func updateFilter(with newFilterValue: ProfileThreadFilter) {
        threads = []
        replies = []
        
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

// MARK: - Threads

extension UserContentListViewModel {
    
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
        
}

// MARK: - Replies

extension UserContentListViewModel {
    
    func fetchUserReplies() async throws {
        self.replies = try await ThreadService.fetchThreadReplies(forUser: user)
        
        if replies.isEmpty {
            emptyMessage = selectedFilter.emptyMessage
            return
        } else {
            emptyMessage = ""
        }
        
        try await fetchReplyThreadData()
    }
    
    func fetchReplyThreadData() async throws {
        
        for i in 0..<replies.count {
            let reply = replies[i]
            
            var thread = try await ThreadService.fetchThread(threadId: reply.threadId)
            thread.user = try await UserService.fetchUser(with: thread.ownerUid)
            
            replies[i].thread = thread
        }
        
    }
    
}

// MARK: - Reposts

extension UserContentListViewModel {
    
    func fetchUserReposts() async throws {
        threads = []
        if threads.isEmpty {
            emptyMessage = selectedFilter.emptyMessage
        } else {
            emptyMessage = ""
        }
    }
    
}

// MARK: - Likes

extension UserContentListViewModel {
    
    func fetchUserLikes() async throws {
        self.threads = try await ThreadService.fetchUserLikedThreads(with: user.id)
        if threads.isEmpty {
            emptyMessage = selectedFilter.emptyMessage
        } else {
            emptyMessage = ""
        }
    }
    
}
