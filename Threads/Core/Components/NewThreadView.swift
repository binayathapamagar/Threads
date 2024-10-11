//
//  NewThreadView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-10.
//

import SwiftUI

struct NewThreadView: View {
    let user: User?
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: user, size: .small)

            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.username ?? "@username")
                        .fontWeight(.semibold)
                    
                    Text("What's new?")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.icon)
                    
                }//VStack
                .font(.subheadline)
                
                HStack(alignment: .bottom, spacing: 16) {
                    Button {
                    } label: {
                        Image(systemName: "photo")
                            .foregroundStyle(.icon)
                    }//Button
                    .disabled(true)
                    
                    Button {
                    } label: {
                        Image(systemName: "camera")
                            .foregroundStyle(.icon)
                    }//Button
                    .disabled(true)
                    
                    Spacer()
                }
                
            }//VStack
        }//HStack
    }
}

#Preview {
    NewThreadView(user: DeveloperPreview.shared.user)
}
