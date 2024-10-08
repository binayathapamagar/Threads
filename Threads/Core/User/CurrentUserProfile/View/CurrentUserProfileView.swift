//
//  CurrentUserProfileView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-10-07.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    @StateObject private var viewModel = CurrentUserProfileViewModel()
    
    private var currentUser: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    //Header
                    ProfileHeaderView(user: currentUser)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.appPrimary)
                            .frame(maxWidth: .infinity, minHeight: 32)
                            .background(.appSecondary)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 8)
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(Color(.systemGray4), lineWidth: 1)
                            }
                    })
                    
                    UserContentListView()
                }//VStack
                .padding(.top, 16)
            }//ScrollView
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .tint(.primary)
        }//NavigationStack
        
    }
}

#Preview {
    CurrentUserProfileView()
}
