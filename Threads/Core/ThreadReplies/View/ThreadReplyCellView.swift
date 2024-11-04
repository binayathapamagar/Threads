//
//  ThreadReplyCellView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-11-02.
//

import SwiftUI

struct ThreadReplyCellView: View {
    let threadReply: ThreadReply
    
    private var replyUser: User? {
        threadReply.replyUser
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(user: replyUser, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        
                        //Username
                        Text(replyUser?.username ?? "@username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text(threadReply.timestamp.timeAgoDisplay())
                            .font(.footnote)
                            .foregroundStyle(Color(.systemGray2))
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        })
                    }//HStack
                    
                    //Thread content
                    Text(threadReply.replyText)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    //Tightly coupled to a thread so will have to make this View accept a generic value that can be a thread or a reply.
                    //Action buttons
                    //                    if let thread = threadReply.thread {
                    //                        ContentActionButtonsView(thread: thread)
                    //                            .padding(.vertical, 8)
                    //                    }
                    
                }//VStack
                
            }//HStack
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical)
        }//VStack
    }
}

#Preview {
    ThreadReplyCellView(threadReply: DeveloperPreview.shared.threadReply)
}
