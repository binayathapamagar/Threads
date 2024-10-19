//
//  FeedView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    @Binding var showCreateThread: Bool
    private var user: User? {
        UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    NewThreadView(user: user)
                        .padding(.top)
                        .padding(.horizontal)
                        .onTapGesture {
                            showCreateThread = true
                        }
                    Divider()
                        .padding(.top)
                    
                    LazyVStack(content: {
                        ForEach(viewModel.threads) { thread in
                            ThreadCellView(thread: thread)
                        }//ForEach
                    })//LazyVStack
                }//ScrollView
                if viewModel.showLoadingSpinner {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        AuthProgressView()
                    }//VStack
                }
            }//ZStack
            .refreshable {
                Task { try await viewModel.fetchThreads() }
            }//refreshable
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    }
                }//ToolbarItem
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Right button tapped")
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundStyle(.appPrimary)
                    }
                }//ToolbarItem
            }//toolbar
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationStack
    }
}

#Preview {
    FeedView(showCreateThread: .constant(false))
}
