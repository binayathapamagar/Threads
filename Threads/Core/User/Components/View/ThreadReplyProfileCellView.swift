//
//  ThreadReplyProfileCellView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-11-19.
//

import SwiftUI

struct ThreadReplyProfileCellView: View {
    let reply: ThreadReply
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                // MARK: - Thread View
                if let thread = reply.thread {
                    HStack(alignment: .top) {
                        VStack {
                            CircularProfileImageView(user: thread.user, size: .small)
                            
                            Rectangle()
                                .frame(width: 2, height: 64)
                                .foregroundStyle(Color(.systemGray4))
                        }//VStack
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                
                                //Username
                                Text(thread.user?.username ?? "@username")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Text(thread.timestamp.timeAgoDisplay())
                                    .font(.footnote)
                                    .foregroundStyle(Color(.systemGray2))
                            }//HStack
                            
                            //Thread content
                            Text(thread.content)
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                            
                            //Action buttons
                            ContentActionButtonsView(thread: thread)
                                .padding(.vertical, 8)
                            
                        }//VStack
                        
                        Spacer()
                    }//HStack
                }
                
                // MARK: - Reply View
                HStack(alignment: .top) {
                    CircularProfileImageView(user: reply.replyUser, size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(reply.replyUser?.username ?? "")
                            .fontWeight(.semibold)
                        
                        Text(reply.replyText)
                    }//VStack
                    .font(.subheadline)
                    
                    Spacer()
                    
                }//HStack
                
            }//VStack
            .padding(.top, 8)
            .padding(.horizontal)
            
            Divider()
                .padding(.top, 8)
        }//VStack
    }
}

#Preview {
    ThreadReplyProfileCellView(reply: DeveloperPreview.shared.threadReply)
}
