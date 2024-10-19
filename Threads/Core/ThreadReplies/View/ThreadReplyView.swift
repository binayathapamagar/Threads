//
//  ThreadReplyView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-18.
//

import SwiftUI

struct ThreadReplyView: View {
    @StateObject private var viewModel = ThreadReplyViewModel()
    @State var reply: String = ""
    @Environment(\.dismiss) var dismiss
    
    let thread: Thread
    
    private var threadUser: User? {
        thread.user
    }
    
    private var currentUser: User? {
        UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                 
                //Thread
                VStack(alignment: .leading, spacing: 4){
                    HStack(alignment: .top) {
                        VStack {
                            CircularProfileImageView(user: threadUser, size: .small)
                            
                            Rectangle()
                                .frame(width: 2, height: viewModel.threadViewHeight)
                                .foregroundStyle(Color(.systemGray4))
                        }//VStack
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(threadUser?.username ?? "username")
                                .fontWeight(.semibold)
                            
                            Text(thread.content)
                                .multilineTextAlignment(.leading)
                        }//VStack
                        .font(.subheadline)
                        
                        Spacer()
                    }//HStack
                    
                    //Reply
                    HStack(alignment: .top) {
                        CircularProfileImageView(user: currentUser, size: .small)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(currentUser?.username ?? "username")
                                .fontWeight(.semibold)
                            
                            TextField("Reply to \(threadUser?.username ?? "")...", text: $reply, axis: .vertical)
                                .multilineTextAlignment(.leading)
                        }//VStack
                        .font(.subheadline)
                        
                        Spacer()
                        
                        if !reply.isEmpty {
                            Button {
                                reply = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.gray)
                            }//Button
                        }
                    }//HStack
                }//VStack
                .padding()
                
                Spacer()
            }//VStack
            .onAppear {
                viewModel.setThreadViewHeight(with: thread)
            }
            .navigationTitle("Reply")
            .navigationBarTitleDisplayMode(.inline )
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.appPrimary)
                }//ToolbarItem
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Post") {
                        Task {
                            dismiss()
                        }
                    }
                    .opacity(reply.isEmpty ? 0.5 : 1.0)
                    .disabled(reply.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.appPrimary)
                }//ToolbarItem
            }//toolbar
        }//NavigationStack
    }
}

#Preview {
    ThreadReplyView(thread: DeveloperPreview.shared.thread)
}
