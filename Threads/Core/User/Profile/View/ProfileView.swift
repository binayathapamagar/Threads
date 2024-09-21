//
//  ProfileView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-06.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selectedFilter: ProfileThreadFilter = .threads
    @Namespace var animation
    
    private var currentUser: User? {
        viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //Header
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        //Content
                        VStack(alignment: .leading, spacing: 12) {
                            //Name and username
                            VStack(alignment: .leading, spacing: 4) {
                                Text(currentUser?.fullName ?? "Full Name")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("@\(currentUser?.username ?? "Username")")
                                    .font(.subheadline)
                            }
                            
                            //Bio and followers count
                            if let bio = currentUser?.bio {
                                Text(bio)
                                    .font(.footnote)
                            }
                            
                            Text("981m followers")
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }//VStack
                        
                        Spacer()
                        
                        CircularProfileView()
                    }//HStack
                    
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
                    })
                    
                    //User content list view
                    VStack {
                        HStack {
                            ForEach(ProfileThreadFilter.allCases) { filter in
                                VStack {
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(
                                            selectedFilter == filter ? .semibold : .regular
                                        )
                                    
                                    if selectedFilter == filter {
                                        Rectangle()
                                            .foregroundStyle(.appPrimary)
                                            .frame(maxWidth: .infinity, maxHeight: 1)
                                            .matchedGeometryEffect(id: "sharedID", in: animation)
                                    } else {
                                        Rectangle()
                                            .foregroundStyle(.clear)
                                            .frame(maxWidth: .infinity, maxHeight: 1)
                                    }
                                }//VStack
                                .onTapGesture {
                                    withAnimation(.spring) {
                                        selectedFilter = filter
                                    }
                                }
                            }//ForEach
                        }//HStack
                        
                        //Content List
                        LazyVStack {
                            ForEach(0...10, id: \.self) { thread in
                                ThreadCellView()
                            }//ForEach
                        }//LazyVStack
                    }//VStack
                    
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
    ProfileView()
}
