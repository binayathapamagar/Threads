//
//  CreateThreadView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct CreateThreadView: View {
    @State private var content = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileView()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Leo Messi")
                            .fontWeight(.semibold)
                        
                        TextField("Create a thread...", text: $content, axis: .vertical)
                    }//VStack
                    .font(.footnote)
                    
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
