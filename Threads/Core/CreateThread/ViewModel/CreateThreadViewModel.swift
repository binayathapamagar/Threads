//
//  ThreadsCreationViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-09.
//

import FirebaseAuth
import FirebaseCore

class CreateThreadViewModel: ObservableObject {
    @Published var showLoadingSpinner = false

    @MainActor
    func uploadThread(with content: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        showLoadingSpinner = true

        defer {
            showLoadingSpinner = false
        }
        
        let thread = Thread(
            ownerUid: uid,
            content: content,
            timestamp: Timestamp(),
            likes: 0,
            comments: 0,
            reposts: 0,
            shares: 0
        )
        try await ThreadService.upload(thread)
    }
    
}