//
//  ProfileView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    var body: some View {
        ScrollView {
            //Header
            VStack(spacing: 20) {
                ProfileHeaderView(user: user)
                    .padding(.horizontal)
                
                Button(action: {}, label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBackground))
                        .frame(maxWidth: .infinity, minHeight: 32)
                        .background(.appPrimary)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .padding(.horizontal)
                })
                
                UserContentListView()
            }//VStack
            .padding(.top, 16)
        }//ScrollView
        .scrollIndicators(.hidden)
        .tint(.appPrimary)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(user: DeveloperPreview.shared.user)
}
