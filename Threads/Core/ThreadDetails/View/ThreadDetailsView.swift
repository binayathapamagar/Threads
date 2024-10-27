//
//  ThreadDetailsView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-26.
//

import SwiftUI

struct ThreadDetailsView: View {
    @StateObject var viewModel = ThreadDetailsViewModel()
    
    let thread: Thread
    
    var body: some View {
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
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(thread.content)
                        .font(.subheadline)

                    ContentActionButtonsView(thread: thread)
                }//VStack
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .padding(.vertical)
            }//VStack
        }//ScrollView
    }
}

#Preview {
    ThreadDetailsView(thread: DeveloperPreview.shared.thread)
}
