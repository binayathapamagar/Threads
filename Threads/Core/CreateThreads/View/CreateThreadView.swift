//
//  CreateThreadView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct CreateThreadView: View {
    @StateObject private var viewModel = CreateThreadViewModel()
    @State private var content = ""
    @Environment(\.dismiss) var dismiss
    
    private var user: User? {
        UserService.shared.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack(alignment: .top, spacing: 12) {
                        CircularProfileImageView(user: user, size: .small)
                        
                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user?.username ?? "username")
                                    .fontWeight(.semibold)
                                
                                TextField("What's new?", text: $content, axis: .vertical)
                            }//VStack
                            .font(.subheadline)
                            
                            HStack(alignment: .bottom, spacing: 24) {
                                Button {
                                } label: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(.icon)
                                }//Button
                                
                                Button {
                                } label: {
                                    Image(systemName: "camera")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                    .foregroundStyle(.icon)                                }//Button
                                
                                Spacer()
                            }
                            
                        }//VStack
                        
                        Spacer()
                        
                        if !content.isEmpty {
                            Button {
                                content = ""
                            } label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundStyle(.gray)
                            }//Button
                        }
                    }//HStack
                    
                    Spacer()
                }//VStack
                .padding()
                
                if viewModel.showLoadingSpinner {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        AuthProgressView()
                    }//VStack
                }
            }//ZStack
            .navigationTitle("New Thread")
            .navigationBarTitleDisplayMode(.inline)
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
                            try await viewModel.uploadThread(with: content)
                            dismiss()
                        }
                    }
                    .opacity(content.isEmpty ? 0.5 : 1.0)
                    .disabled(content.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.appPrimary)
                }//ToolbarItem
            }//toolbar
        }//NavigationStack
    }
}

#Preview {
    CreateThreadView()
}
