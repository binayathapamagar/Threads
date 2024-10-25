//
//  ThreadReplyViewModel.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-18.
//

import UIKit
import Firebase
import FirebaseAuth

class ThreadReplyViewModel: ObservableObject {
    @Published var showLoadingSpinner = false
    @Published var threadViewHeight: CGFloat = 24 //Default value to fall back on
    
    @MainActor
    func uploadThreadReply(replyText: String, thread: Thread) async throws {
        showLoadingSpinner = true
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        defer {
            showLoadingSpinner = false
        }
        
        let threadReply = ThreadReply(
            threadId: thread.id,
            replyText: replyText,
            threadReplyOwnerUid: uid,
            threadOwnerUid: thread.ownerUid,
            timestamp: Timestamp()
        )
        
        try await ThreadReplyService.uploadThreadReply(threadReply, to: thread)
    }
}

// MARK: - UI methods

extension ThreadReplyViewModel {
    
    func setThreadViewHeight(with thread: Thread) {
        guard let screenWidth = UIScreen.current?.bounds.size.width else { return }
        let imageDimension: CGFloat = ProfileImageSize.small.dimension
        let padding: CGFloat = 16
        //        let spacing: CGFloat = 8
        let replyTextFieldWidth = screenWidth - imageDimension - padding
        //        let replyTextFieldWidth = screenWidth - imageDimension - padding - spacing
        
        let font = UIFont.systemFont(ofSize: 15)
        
        let threadContentHeight = thread.content.heightWithConstraintWidth(replyTextFieldWidth, font: font)
        
        print(#function, "DEBUG: Height of the thread content: \(threadContentHeight)")
        
        //        let rootVStackSpacing: CGFloat = 8
        //        let threadUsernameThreadContentSpacing: CGFloat = 4
        
        //Adding the image's height & the thread's content height
        threadViewHeight = threadContentHeight + imageDimension - padding
        
        //        threadViewHeight = threadContentHeight + imageDimension - padding - spacing - rootVStackSpacing - threadUsernameThreadContentSpacing
        
        print(#function, "DEBUG: Height of the thread view: \(threadViewHeight)")
    }
    
}
