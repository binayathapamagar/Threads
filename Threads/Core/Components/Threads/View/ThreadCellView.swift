//
//  ThreadCell.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-07.
//

import SwiftUI

struct ThreadCellView: View {
    let thread: Thread
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                CircularProfileImageView(user: thread.user, size: .small)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        
                        //Username
                        Text(thread.user?.username ?? "@username")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text(thread.timestamp.timeAgoDisplay())
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray2))
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        })
                    }//HStack
                    
                    //Thread content
                    Text(thread.content)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    //Action buttons
                    ContentActionButtonsView(thread: thread)
                        .padding(.vertical, 8)
                    
                }//VStack
                
            }//HStack
            
            Divider()
        }//VStack
        .padding(.top)
    }
}

#Preview {
    ThreadCellView(thread: DeveloperPreview.shared.thread)
}
