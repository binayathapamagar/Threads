//
//  ContentActionButtonsViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-16.
//

import Foundation

@MainActor
class ContentActionButtonsViewModel: ObservableObject {
    @Published var thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
        Task { try await checkIfUserLikedThread() }
    }
    
    func likeThread() async throws {
        try await ThreadService.likeThread(thread)
        self.thread.didLike = true
        self.thread.likes += 1
    }
    
    func unlikeThread() async throws {
        try await ThreadService.unlikeThread(thread)
        self.thread.didLike = false
        self.thread.likes -= 1
    }
    
    func handleLikeAction() async throws {
        guard let didLike = thread.didLike else { return }
        if didLike {
            try await unlikeThread()
        } else {
            try await likeThread()
        }
    }
    
    func checkIfUserLikedThread() async throws {
        let didLike = try await ThreadService.userHasLikedThread(thread)
        
        //Only publishing the changes if the user has liked it before as
        //by default it will be false. We would firing off unnecessary
        //publishing events to update the UI.
        if didLike {
            thread.didLike = true
        }
    }
    
}
