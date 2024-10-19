//
//  ContentActionButtonsView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-16.
//

import SwiftUI

struct ContentActionButtonsView: View {
    @ObservedObject private var viewModel: ContentActionButtonsViewModel
    @State private var showReplySheet: Bool = false
    
    init(thread: Thread) {
        self.viewModel = ContentActionButtonsViewModel(thread: thread)
    }
    
    private var thread: Thread {
        viewModel.thread
    }
    
    private var didLike: Bool {
        viewModel.thread.didLike ?? false
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 24) {
            HStack(spacing: 4) {
                Button(action: {
                    Task { try await viewModel.handleLikeAction() }
                }, label: {
                    Image(systemName:didLike ? "heart.fill" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                        .foregroundStyle(didLike ? .red : .secondary)
                })
                
                if thread.likes > 0 {
                    Button {} label: {
                        Text("\(thread.likes)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 14))
                    }
                }
            }
            Button(action: {
                showReplySheet.toggle()
            }, label: {
                Image(systemName: "bubble.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.secondary)
            })
            Button(action: {}, label: {
                Image(systemName: "arrow.rectanglepath")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.secondary)
            })
            Button(action: {}, label: {
                Image(systemName: "paperplane")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.secondary)
            })
        }//HStack
        .sheet(isPresented: $showReplySheet) {
            ThreadReplyView(thread: thread)
        }
    }
}

#Preview {
    ContentActionButtonsView(thread: DeveloperPreview.shared.thread)
}
