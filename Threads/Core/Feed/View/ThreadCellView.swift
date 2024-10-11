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

                        Text(thread.timestamp.dateValue().description)
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
                    HStack(spacing: 16) {
                        Button(action: {}, label: {
                            Image(systemName: "heart")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "bubble.right")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "arrow.rectanglepath")
                        })
                        Button(action: {}, label: {
                            Image(systemName: "paperplane")
                        })
                    }//HStack
                    .foregroundStyle(.secondary)
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
