//
//  FeedView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(content: {
                    ForEach(viewModel.threads) { thread in
                        ThreadCellView(thread: thread)
                            .padding(.horizontal)
                    }//ForEach
                })//LazyVStack
            }//ScrollView
            .refreshable {
                print("Pull to refresh")
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
    FeedView()
}
