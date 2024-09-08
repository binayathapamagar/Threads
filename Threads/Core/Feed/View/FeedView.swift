//
//  FeedView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(content: {
                    ForEach(1...10, id: \.self) { thread in
                        ThreadCellView()
                    }//ForEach
                })//LazyVStack
            }//ScrollView
            .refreshable {
                print("Pull to refresh")
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Right button tapped")
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundStyle(.black)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }//NavigationStack
    }
}

#Preview {
    FeedView()
}
