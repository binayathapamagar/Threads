//
//  ThreadDetailsView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-26.
//

import SwiftUI

struct ThreadDetailsView: View {
    @StateObject var viewModel: ThreadDetailsViewModel
    
    let thread: Thread

    init(thread: Thread) {
        self.thread = thread
        self._viewModel = StateObject(
            wrappedValue: ThreadDetailsViewModel(thread: thread)
        )
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        CircularProfileImageView(user: thread.user, size: .small)
                        
                        Text(thread.user?.username ?? "@username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text(thread.timestamp.timeAgoDisplay())
                            .font(.footnote)
                            .foregroundStyle(Color(.systemGray3))
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        })
                    }//HStack
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(thread.content)
                            .font(.subheadline)

                        ContentActionButtonsView(thread: thread)
                    }//VStack
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.top)
                    
                    HStack {
                        Text("Replies")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            print("Show user likes")
                        } label: {
                            HStack(spacing: 4) {
                                Text("View activity")
                                
                                Image(systemName: "chevron.right")
                            }//HStack
                            .font(.subheadline)
                            .foregroundStyle(.dividerBG)
                        }//Button
                    }//HStack
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.bottom)
                    
                    LazyVStack{
                        ForEach(viewModel.replies) { reply in
                            ThreadReplyCellView(threadReply: reply)
                        }
                    }//LazyVStack
                }//VStack
            }//ScrollView
            .padding(.vertical)
            
            if viewModel.showLoadingSpinner {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    AuthProgressView()
                }
            }
        }
        .navigationTitle("Thread")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ThreadDetailsView(thread: DeveloperPreview.shared.thread)
    }
}
