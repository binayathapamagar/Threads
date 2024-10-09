//
//  EditProfileView.swift
//  Threads
//
//  Created by BINAYA THAPA MAGAR on 2024-09-09.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivate = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CurrentUserProfileViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea(edges: [.bottom, .horizontal])
                
                VStack {
                    //Name and profile pic
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            Text("Leo Andres Messi")
                        }
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem) {
                            if let image = viewModel.profileImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                CircularProfileView()
                            }
                        }
                    }//HStack
                    
                    Divider()
                    
                    //Username
                    VStack(alignment: .leading) {
                        Text("Username")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your username...", text: $link)
                    }//VStack
                    
                    Divider()
                    
                    //Bio
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                        
                        TextField("Enter your bio...", text: $bio, axis: .vertical)
                    }//VStack
                    
                    Divider()
                    
                    //Link
                    VStack(alignment: .leading) {
                        Text("Link")
                            .fontWeight(.semibold)
                        
                        TextField("Add link ...", text: $link)
                    }//VStack
                    
                    Divider()
                    
                    Toggle("Private Profile", isOn: $isPrivate)
                    
                }//VStack
                .font(.footnote)
                .padding()
                .background(.appSecondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.systemGray4), lineWidth: 1)
                )
                .padding()
                
            }//ZStack
            .navigationTitle("Edit Profile")
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
                    Button("Done") {}
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.appPrimary)
                }//ToolbarItem
            }//Toolbar
        }//NavigationStack
    }
}

#Preview {
    EditProfileView()
        .environmentObject(CurrentUserProfileViewModel())
}
